object errorInterpreter {

  trait M[A] {
    def show: String
    def bind[B](k: A => M[B]): M[B]
    def map[B](f: A => B): M[B]         =  bind(x => unitM(f(x)))
    def flatMap[B](f: A => M[B]): M[B]  =  bind(f)
  }

  def unitM[A](a: A): M[A]          =  new Suc(a)
  def errorM[A](msg: String): M[A]  =  new Err(msg)

  def showM(m: M[Value]): String = m.show

  class Suc[A](x: A) extends M[A] {
    def bind[B](k: A => M[B]): M[B] = k(x)
    def show: String = "Success: " + x
  }
  class Err[A](msg: String) extends M[A] {
    def bind[B](k: A => M[B]): M[B] = new Err(msg)
    def show: String = "Error: " + msg
  }

  type Name = String

  trait Term
  case class Var(x: Name) extends Term
  case class Con(n: int) extends Term
  case class Add(l: Term, r: Term) extends Term
  case class Lam(x: Name, body: Term) extends Term
  case class App(fun: Term, arg: Term) extends Term

  trait Value
  case object Wrong extends Value {
    override def toString() = "wrong"
  }
  case class Num(n: int) extends Value {
    override def toString() = n.toString()
  }
  case class Fun(f: Value => M[Value]) extends Value {
    override def toString() = "<function>"
  }

  type Environment = List[Pair[Name, Value]]

  def lookup(x: Name, e: Environment): M[Value] = e match {
    case List() => errorM("unbound variable: " + x);
    case Pair(y, b) :: e1 => if (x == y) unitM(b) else lookup(x, e1)
  }

  def add(a: Value, b: Value): M[Value] = Pair(a, b) match {
    case Pair(Num(m), Num(n)) => unitM(Num(m + n))
    case _ => errorM("should be numbers: " + a + "," + b)
  }

  def apply(a: Value, b: Value): M[Value] = a match {
    case Fun(k) => k(b)
    case _ => errorM("should be function: " + a)
  }

  def interp(t: Term, e: Environment): M[Value] = t match {
    case Var(x) => lookup(x, e)
    case Con(n) => unitM(Num(n))
    case Add(l, r) => for (a <- interp(l, e);
                           b <- interp(r, e);
                           c <- add(a, b))
                      yield c
    case Lam(x, t) => unitM(Fun(a => interp(t, Pair(x, a) :: e)))
    case App(f, t) => for (a <- interp(f, e);
                           b <- interp(t, e);
                           c <- apply(a, b))
                      yield c
  }

  def test(t: Term): String =
    showM(interp(t, List()))

  val term0 = App(Lam("x", Add(Var("x"), Var("x"))), Add(Con(10), Con(11)))
  val term1 = App(Con(1), Con(2))

  def main(args: Array[String]) = {
    System.out.println(test(term0))
    System.out.println(test(term1))
  }
}

