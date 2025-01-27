package examples.actors

import scala.actors.Actor._

object looping extends Application {
  case object A

  val a = actor {
    var cnt = 0
    loop {
      react {
        case A =>
          cnt = cnt + 1
          if (cnt % 2 != 0) continue
          if (cnt < 10)
            println("received A")
          else {
            println("received last A")
            exit()
          }
      }
    }
  }

  for (val i <- 0 until 10) {
    a ! A
  }
}
