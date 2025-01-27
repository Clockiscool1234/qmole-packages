/*
 * Copyright (C) 1997-2004, Michael Jennings
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies of the Software, its documentation and marketing & publicity
 * materials, and acknowledgment shall be given in the documentation, materials
 * and software packages that this Software was used.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/**
 * @file types.h
 * LibAST Portable Data Types
 *
 * This file contains a collection of well-defined data types and the
 * tools for manipulating them.
 *
 * @author Michael Jennings <mej@eterm.org>
 * $Revision: 1.8 $
 * $Date: 2003/06/17 00:44:08 $
 */

#ifndef _LIBAST_TYPES_H_
#define _LIBAST_TYPES_H_


/**
 * @defgroup DOXGRP_TYPES LibAST Portable Data Types
 *
 * A collection of well-defined data types and the tools for
 * manipulating them.
 *
 * As any C programmer who cares about portability knows, dealing with
 * different types on different platforms can be a problem.  On some
 * platforms, int is 16-bit and long is 32-bit; on others, both int
 * and long are 32-bit and there is no long long; others have long
 * long as a 64-bit integer; and then there are the native 64-bit
 * platforms where long can also be 64-bit.  Not to mention the
 * presence/absence of boolean types/defines, signed vs. unsigned
 * char, and so forth.
 *
 * LibAST solves this problem by defining data types for specific
 * integer sizes that are guaranteed to be defined on any system with
 * LibAST.  Also, the basic data types are given their own new data
 * types which make signedness vs. unsignedness specifically stated,
 * preventing bad assumptions.
 *
 * Also included are macros for building LibAST type names from their
 * basenames, allocating LibAST objects, typecasting, generating
 * type-specific NULL comparisons, stringizing NULL values, taking the
 * size of a LibAST object type, and more.
 *
 * There are a few potential gotchas here, so please read the
 * following documentation carefully for each part you wish to use.
 */

/*@{*/
/**
 * @name Type Name Composition Macros
 * ---
 *
 * These macros convert basenames like "obj" into actual typenames
 * like "spif_obj_t."  This is primarily intended for use by other
 * macros and in places where the basename of the type should be
 * emphasized.
 *
 * @note LibAST's use of the term "const type" does @em NOT match the
 * traditional C definition of the term @c const.  When you declare a
 * variable of a type like @c spif_obj_t or @c SPIF_TYPE(obj), you are
 * actually defining a pointer variable which will point to an object
 * of that type.  Why a pointer?  Because they're the closest thing C
 * has to references.  However, in places where the actual structure
 * is needed as opposed to to a pointer (like when using sizeof()),
 * the @c CONST version of the macro should be used instead.
 *
 * @ingroup DOXGRP_TYPES
 */

/**
 * Create a complete type name from its basename.
 *
 * This macro converts a basename (such as "obj" or "charptr" or
 * "uint8") into a namespace-safe full type name.
 *
 * @param type The type basename.
 * @return     The full type name.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
#define SPIF_TYPE(type)                  spif_ ## type ## _t

/**
 * Create a complete const type name from its basename.
 *
 * This macro converts a basename (such as "obj" or "charptr" or
 * "uint8") into a namespace-safe const type name.
 *
 * @param type The type basename.
 * @return     The full const type name.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
#define SPIF_CONST_TYPE(type)            spif_const_ ## type ## _t

/**
 * Obtain the size of a type from its basename.
 *
 * This macro returns the size of the given type basename (such as
 * "obj" or "str").  This is only used for objects and other
 * structures whose types are actually struct pointers.
 *
 * @param type The type basename.
 * @return     The size of objects/structures of that type.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
#define SPIF_SIZEOF_TYPE(type)           (sizeof(SPIF_CONST_TYPE(type)))

/**
 * Define a type and its corresponding const type.
 *
 * This macro creates a typedef which maps the const type @a t to the
 * type specified by @a u and a typedef which maps the type @a t to a
 * pointer to its const type.  Again, this is used for structures.
 *
 * @param t The type basename.
 * @param u The actual type it's being mapped to.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
#define SPIF_DECL_TYPE(t, u)           typedef u SPIF_CONST_TYPE(t); typedef SPIF_CONST_TYPE(t) * SPIF_TYPE(t)
/*@}*/

/*@{*/
/**
 * @name Object-Specific Macros
 * ---
 *
 * These macros are intended for use specifically with objects.
 *
 * @see @link DOXGRP_OBJ LibAST Object Infrastructure @endlink
 * @ingroup DOXGRP_TYPES
 */

/**
 * Allocate an object (or other structured type) by its basename.
 *
 * This macro is used primarily in object constructors.  It allocates
 * and returns the specified type.
 *
 * @param type The type basename.
 * @return     An allocated object of the specified type.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
#define SPIF_ALLOC(type)                 SPIF_CAST(type) MALLOC(SPIF_SIZEOF_TYPE(type))

/**
 * Deallocate an object (or other structured type).
 *
 * This macro is used primarily in object destructors.  It frees the
 * memory associated with the specified object and invalidates it.
 *
 * @param obj The object to be freed.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
#define SPIF_DEALLOC(obj)                FREE(obj)

/**
 * Builds the classname variable for a particular base type.
 *
 * This macro converts a basename into the classname for that type.
 * It is primarily used in initialization of class objects.
 *
 * @param type The type basename.
 * @return     A string representing the classname for that type.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
#define SPIF_DECL_CLASSNAME(type)        SPIF_CAST(charptr) "!spif_" #type "_t!"
/*@}*/

/*@{*/
/**
 * @name Typecast Macros
 * ---
 *
 * These macros provide typecasting by basename for LibAST types.
 * Cast macros are also provided for native C types to provide
 * consistency of casting method.
 *
 * @ingroup DOXGRP_TYPES
 */

/**
 * Typecast to a native C type.
 *
 * This macro is identical to traditional C typecasting and is
 * supplied primarily for consistency.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
#define SPIF_CAST_C(type)                (type)

/**
 * Typecast to a const native C type.
 *
 * This macro is identical to traditional C typecasting, except that
 * the @c const keyword is added to the typecast.  It is supplied
 * primarily for consistency.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
#define SPIF_CONST_CAST_C(type)          (const type)

/**
 * Typecast to a LibAST type by basename.
 *
 * This macro typecasts a value to a particular LibAST type by its
 * basename.  It is usually employed where emphasis on the basename is
 * desired, particularly with objects.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, SPIF_TYPE()
 */
#define SPIF_CAST(type)                  (SPIF_TYPE(type))

/**
 * Typecast to a const LibAST type by basename.
 *
 * This macro is identical to SPIF_CAST(), except that the @c const
 * keyword is added to the typecast.
 *
 * @note DO NOT confuse this typecast with the "const type"
 * terminology.  This typecast applies const-ness (i.e., immutability)
 * to an object or other value.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, SPIF_TYPE(), SPIF_CAST()
 */
#define SPIF_CONST_CAST(type)            (const SPIF_TYPE(type))

/**
 * Typecast to a pointer to a LibAST type by basename.
 *
 * This macro typecasts a value to a pointer to a particular LibAST
 * type by its basename.  It is usually employed where emphasis on the
 * basename is desired, particularly with objects.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, SPIF_TYPE()
 */
#define SPIF_CAST_PTR(type)              (SPIF_TYPE(type) *)

/**
 * Typecast to a pointer to a const LibAST type by basename.
 *
 * This macro is identical to SPIF_CAST_PTR(), except that the @c
 * const keyword is added to the typecast.
 *
 * @note DO NOT confuse this typecast with the "const type"
 * terminology.  This typecast applies const-ness (i.e., immutability)
 * to the object or other value referenced by the pointer.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, SPIF_TYPE(), SPIF_CAST_PTR()
 */
#define SPIF_CONST_CAST_PTR(type)        (const SPIF_TYPE(type) *)
/*@}*/

/*@{*/
/**
 * @name NULL Handling Macros
 * ---
 *
 * These macros handle typecasting the NULL pointer to a specific
 * basename/type and printing out values which are set to NULL of a
 * specific basename/type.
 *
 * @ingroup DOXGRP_TYPES
 */

/**
 * Returns a NULL object of the specified base type.
 *
 * This macro returns a NULL object of the type specified by the given
 * basename.  It is generally used for initializing object member
 * variables and for returning correctly-typed NULL objects.
 *
 * @param type The type basename.
 * @return     A NULL object of the specified type.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, SPIF_CAST()
 */
#define SPIF_NULL_TYPE(type)             (SPIF_CAST(type) (NULL))

/**
 * Returns a NULL object of the specified native C type.
 *
 * This macro returns a NULL object of the specified C type.  It is
 * included primarily for consistency.
 *
 * @param type The native C type.
 * @return     A NULL value of the specified type.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, SPIF_CAST_C()
 */
#define SPIF_NULL_TYPE_C(type)            (SPIF_CAST_C(type) (NULL))

/**
 * Returns a NULL pointer to an object of the specified base type.
 *
 * This macro returns a NULL pointer to an object of the type
 * specified by the given basename.  It is generally used for
 * initializing object member variables and for returning
 * correctly-typed NULL objects.
 *
 * @param type The type basename.
 * @return     A NULL pointer to an object of the specified type.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, SPIF_CAST()
 */
#define SPIF_NULL_TYPE_PTR(type)          (SPIF_CAST_PTR(type) (NULL))

/**
 * Returns a string representing a NULL value of the specified base
 * type.
 *
 * This macro returns a string which shows the NULL value typecast to
 * the specified type.  This is a convenience macro used primarily by
 * the "show" method of various objects.
 *
 * @param type The type basename.
 * @return     A string representation of a NULL object of the
 *             specified type.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
#define SPIF_NULLSTR_TYPE(type)          "{ ((spif_" #type "_t) NULL) }"

/**
 * Returns a string representing a NULL value of the specified native
 * C type.
 *
 * This macro returns a string which shows the NULL value typecast to
 * the specified type.  This is a convenience macro used primarily by
 * the "show" method of various objects.
 *
 * @param type The type basename.
 * @return     A string representation of a NULL value of the
 *             specified C type.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
#define SPIF_NULLSTR_TYPE_C(type)         "{ ((" #type ") NULL) }"

/**
 * Returns a string representing a NULL value of a pointer to the
 * specified base type.
 *
 * This macro returns a string which shows the NULL value typecast to
 * a pointer to the specified type.  This is a convenience macro used
 * primarily by the "show" method of various objects.
 *
 * @param type The type basename.
 * @return     A string representation of a NULL pointer to an object
 *             of the specified type.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
#define SPIF_NULLSTR_TYPE_PTR(type)      "{ ((spif_" #type "_t *) NULL) }"

/**
 * Returns whether or not a generic pointer is NULL.
 *
 * This macro returns whether or not a generic pointer is NULL.
 *
 * @param p The pointer to test.
 * @return  #TRUE if NULL, #FALSE otherwise.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, SPIF_CAST()
 */
#define SPIF_PTR_ISNULL(p)                ((SPIF_CAST(ptr) (p) == SPIF_NULL_TYPE(ptr)) ? (TRUE) : (FALSE))
/*@}*/

/*@{*/
/**
 * @name Sized Integer Data Types
 * ---
 *
 * These type definitions provide integer types which are guaranteed
 * portable, guaranteed to be of a specific size, and guaranteed to be
 * signed or unsigned, according to the name of each type.
 *
 * @note Platforms not supporting an integer type of a given size
 * default to @c long
 *
 * @note The definitions shown here in the documentation correspond to
 * the platform on which the docs were generated and do not
 * necessarily reflect the actual mappings on your platform.
 *
 * @ingroup DOXGRP_TYPES
 */

/**
 * An 8-bit signed integer.
 *
 * An 8-bit signed integer.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef signed   char  spif_int8_t;

/**
 * An 8-bit unsigned integer.
 *
 * An 8-bit unsigned integer.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef unsigned char  spif_uint8_t;

/**
 * A 16-bit signed integer.
 *
 * A 16-bit signed integer.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef signed   short spif_int16_t;

/**
 * A 16-bit unsigned integer.
 *
 * A 16-bit unsigned integer.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef unsigned short spif_uint16_t;

/**
 * A 32-bit signed integer.
 *
 * A 32-bit signed integer.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef signed   int spif_int32_t;

/**
 * A 32-bit unsigned integer.
 *
 * A 32-bit unsigned integer.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef unsigned int spif_uint32_t;

/**
 * A 64-bit signed integer.
 *
 * A 64-bit signed integer.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef signed   long long spif_int64_t;

/**
 * A 64-bit unsigned integer.
 *
 * A 64-bit unsigned integer.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef unsigned long long spif_uint64_t;
/*@}*/

/*@{*/
/**
 * @name Portable C-Mapped Data Types
 * ---
 *
 * These type definitions provide versions of the native C types which
 * are specifically signed or unsigned.  Also included are an
 * explicitly-signed char pointer type, a generic pointer type, and a
 * generic function pointer type.
 *
 * @ingroup DOXGRP_TYPES
 */

/**
 * A signed char.
 *
 * A signed char.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef signed char spif_char_t;

/**
 * A signed short.
 *
 * A signed short.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef signed short spif_short_t;

/**
 * A signed int.
 *
 * A signed int.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef signed int spif_int_t;

/**
 * A signed long.
 *
 * A signed long.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef signed long spif_long_t;

/**
 * An unsigned char.
 *
 * An unsigned char.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef unsigned char spif_uchar_t;

/**
 * An unsigned short.
 *
 * An unsigned short.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef unsigned short spif_ushort_t;

/**
 * An unsigned int.
 *
 * An unsigned int.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef unsigned int spif_uint_t;

/**
 * An unsigned long.
 *
 * An unsigned long.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef unsigned long spif_ulong_t;

/**
 * A pointer to a signed char.
 *
 * A pointer to a signed char.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef spif_char_t *spif_charptr_t;

/**
 * A pointer to a byte of data.
 *
 * A pointer to a byte of data.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef spif_uint8_t *spif_byteptr_t;

/**
 * A generic, untyped pointer.
 *
 * A generic, untyped pointer.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef void *spif_ptr_t;

/**
 * A generic function pointer.
 *
 * A generic function pointer.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef void * (*spif_func_t)();

/**
 * A class name.
 *
 * This typedef abstracts the actual type of a classname variable.  At
 * this point I can't imagine it needing to be anything else, but one
 * never knows....
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef spif_charptr_t spif_classname_t;

/**
 * Convenience macro for typecasting to spif_charptr_t.
 *
 * This macro typecasts a value to a spif_charptr_t.  I got really
 * tired of typing "SPIF_CAST(charptr)" all the time, especially for
 * string constants. :-)
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, SPIF_CAST(), spif_charptr_t
 */
#define SPIF_CHARPTR(var)    (SPIF_CAST(charptr) (var))

/**
 * Convenience macro for typecasting to C's default char * type.
 *
 * This macro typecasts a value to whatever "char *" is on the current
 * system.  This is used to typecast a spif_charptr_t back to the
 * native C type for use in standard libc functions.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, SPIF_CAST(), spif_charptr_t
 */
#define SPIF_CHARPTR_C(var)  (SPIF_CAST_C(char *) (var))

/*@}*/

/*@{*/
/**
 * @name Portable Socket Types
 * ---
 *
 * These types provide portability and name-mapping for the values
 * and types used in socket code.  These are used by the LibAST socket
 * object and should not need to be used in end-user code.
 *
 * @bug FIXME:  These mappings are currently hard-coded.
 *
 * @ingroup DOXGRP_TYPES
 */

/**
 * A generic socket address.
 *
 * @internal
 * This type references a generic socket address structure.  It is
 * used for typecasting the protocol-based pointers (see below) to a
 * generic type suitable for use as a parameter to socket functions.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
SPIF_DECL_TYPE(sockaddr, struct sockaddr);

/**
 * A socket address for the IPv4 protocol family.
 *
 * @internal
 * This type references an IPv4 socket address structure.  It is used
 * to store IP addressing information for a given socket.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
SPIF_DECL_TYPE(ipsockaddr, struct sockaddr_in);

/**
 * A socket address for the UNIX protocol family.
 *
 * @internal
 * This type references a UNIX socket address structure.  It is used
 * to store addressing information for a given UNIX socket.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
SPIF_DECL_TYPE(unixsockaddr, struct sockaddr_un);

/**
 * An IPv4 address.
 *
 * @internal
 * This type references an IPv4 address in native host format.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
SPIF_DECL_TYPE(ipaddr, struct in_addr);

/**
 * Host information.
 *
 * @internal
 * This type references host information in native host format.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
SPIF_DECL_TYPE(hostinfo, struct hostent);

/**
 * Protocol information.
 *
 * @internal
 * This type references protocol information in native host format.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
SPIF_DECL_TYPE(protoinfo, struct protoent);

/**
 * Service information.
 *
 * @internal
 * This type references service information in native host format.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
SPIF_DECL_TYPE(servinfo, struct servent);

/**
 * The file descriptor for a socket.
 *
 * This type encapsulates the actual type of the socket file
 * descriptor.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef int spif_sockfd_t;

/**
 * The protocol family for a socket.
 *
 * This type encapsulates the actual representation of the protocol
 * family.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef int spif_sockfamily_t;

/**
 * The type of a socket.
 *
 * This type encapsulates the actual representation of the socket
 * type.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef int spif_socktype_t;

/**
 * A socket protocol.
 *
 * This type encapsulates the actual representation of a socket
 * protocol.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef int spif_sockproto_t;

/**
 * A socket port.
 *
 * This type encapsulates the actual representation of a socket's
 * port.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef spif_uint16_t spif_sockport_t;

/**
 * The length of a socket address structure.
 *
 * This type encapsulates the actual representation of the size of a
 * socket address structure.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef socklen_t spif_sockaddr_len_t;
/*@}*/

/*@{*/
/**
 * @name Portable Enumerated Data Types
 * ---
 *
 * These typedefs and macros provide portable, consistent
 * implementations of arbitrary comparison functionality and boolean
 * variables.
 *
 * @ingroup DOXGRP_TYPES
 */

/**
 * An enumerated type for comparisons.
 *
 * The defacto standard for the return value of a function or
 * operation which compares two things comes from the return value of
 * the @c strcmp() family of functions:  An integer less than, equal
 * to, or greater than zero representing that the first value is less
 * than, equal to, or greater than (respectively) the second value.
 * This type makes such comparisons more readable and provides
 * specific, defined values for each case.  Macros are provided to
 * improve readability and simplify conversion from other comparison
 * functions.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, SPIF_CMP_FROM_INT(), SPIF_CMP_IS_LESS(),
 *      SPIF_CMP_IS_EQUAL(), SPIF_CMP_IS_GREATER()
 */
typedef enum {
  SPIF_CMP_LESS = -1,
  SPIF_CMP_EQUAL = 0,
  SPIF_CMP_GREATER = 1
} spif_cmp_t;

/**
 * Convert a traditional integer comparison result to a spif_cmp_t
 * value.
 *
 * This convenience macro accepts an integer value less than, equal
 * to, or greater than zero (as traditionally supplied by comparison
 * functions) and converts that value to SPIF_CMP_LESS,
 * SPIF_CMP_EQUAL, or SPIF_CMP_GREATER, respectively.
 *
 * @note This macro evaluates its parameter twice, so beware of side
 * effects.
 *
 * @param i A traditional integer comparison value.
 * @return  The corresponding spif_cmp_t value.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, spif_cmp_t
 */
#define SPIF_CMP_FROM_INT(i)      ((SPIF_CAST_C(int) (i) < 0) ? (SPIF_CMP_LESS) : ((SPIF_CAST_C(int) (i) > 0) ? (SPIF_CMP_GREATER) : (SPIF_CMP_EQUAL)))

/**
 * Check if a comparison value is SPIF_CMP_LESS.
 *
 * This convenience macro determines if a given comparison expression
 * or value evaluates to SPIF_CMP_LESS.  The @a cmp expression is only
 * evaluated once, so this macro can safely be used on comparison
 * expressions like SPIF_CMP_FROM_INT().
 *
 * @param cmp Comparison expression or value of type spif_cmp_t.
 * @return    True if the result is SPIF_CMP_LESS, false otherwise.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, spif_cmp_t, SPIF_CMP_FROM_INT()
 */
#define SPIF_CMP_IS_LESS(cmp)     ((cmp) == SPIF_CMP_LESS)

/**
 * Check if a comparison value is SPIF_CMP_EQUAL.
 *
 * This convenience macro determines if a given comparison expression
 * or value evaluates to SPIF_CMP_EQUAL.  The @a cmp expression is
 * only evaluated once, so this macro can safely be used on comparison
 * expressions like SPIF_CMP_FROM_INT().
 *
 * @param cmp Comparison expression or value of type spif_cmp_t.
 * @return    True if the result is SPIF_CMP_EQUAL, false otherwise.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, spif_cmp_t, SPIF_CMP_FROM_INT()
 */
#define SPIF_CMP_IS_EQUAL(cmp)    ((cmp) == SPIF_CMP_EQUAL)

/**
 * Check if a comparison value is SPIF_CMP_GREATER.
 *
 * This convenience macro determines if a given comparison expression
 * or value evaluates to SPIF_CMP_GREATER.  The @a cmp expression is
 * only evaluated once, so this macro can safely be used on comparison
 * expressions like SPIF_CMP_FROM_INT().
 *
 * @param cmp Comparison expression or value of type spif_cmp_t.
 * @return    True if the result is SPIF_CMP_GREATER, false otherwise.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink, spif_cmp_t, SPIF_CMP_FROM_INT()
 */
#define SPIF_CMP_IS_GREATER(cmp)  ((cmp) == SPIF_CMP_GREATER)

/**
 * Convenience macro for comparing possibly NULL values.
 *
 * This macro exists because I got tired of typing the same thing over
 * and over again to handle comparisons of two pointers, either of
 * which may be NULL.
 *
 * @param p1  The first pointer.
 * @param p2  The second pointer.
 * @return    
 *
 * @see @link DOXGRP_STRINGS String Utility Routines @endlink, SPIF_PTR_ISNULL()
 */
#define SPIF_COMP_CHECK_NULL(p1, p2) do { \
                                         if (SPIF_PTR_ISNULL((p1)) && SPIF_PTR_ISNULL((p2))) { \
                                             return SPIF_CMP_EQUAL; \
                                         } else if (SPIF_PTR_ISNULL((p1))) { \
                                             return SPIF_CMP_LESS; \
                                         } else if (SPIF_PTR_ISNULL((p2))) { \
                                             return SPIF_CMP_GREATER; \
                                         } \
                                     } while (0)

#undef false
#undef False
#undef FALSE
#undef true
#undef True
#undef TRUE

/**
 * An enumerated type for boolean values.
 *
 * Unlike C++, C does not have a native boolean type.  Having one,
 * while strictly not necessary, tends to make for more readable
 * code.  So LibAST defines a boolean type and maps the most common
 * values into it (i.e., TRUE, True, and true along with FALSE, False,
 * and false).
 *
 * @note Because "false" and "true" are C++ reserved words, compiling
 * LibAST with a C++ compiler will disable these values as members of
 * the spif_bool_t data type.  For this and other reasons (namely
 * readability), use of "TRUE" and "FALSE" is preferred.
 *
 * @see @link DOXGRP_TYPES Portable Data Types @endlink
 */
typedef enum {
#ifndef __cplusplus
  false = 0,
#endif
  False = 0,
  FALSE = 0,
#ifndef __cplusplus
  true = 1,
#endif
  True = 1,
  TRUE = 1
} spif_bool_t;
/*@}*/

#endif /* _LIBAST_TYPES_H_ */
