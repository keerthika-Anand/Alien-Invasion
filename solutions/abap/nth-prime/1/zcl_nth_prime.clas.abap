CLASS zcl_nth_prime DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS prime
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS is_prime
      IMPORTING
        i_num         TYPE i
      RETURNING
        VALUE(r_prime) TYPE abap_bool.
ENDCLASS.

CLASS zcl_nth_prime IMPLEMENTATION.
  METHOD prime.
    " Validate input
    IF input <= 0.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    " Special case: 1st prime is 2
    IF input = 1.
      result = 2.
      RETURN.
    ENDIF.

    DATA(prime_count) = 1.
    DATA(candidate) = 2.

    " Find nth prime
    WHILE prime_count < input.
      candidate += 1.
      
      " Check if candidate is prime
      IF is_prime( candidate ).
        prime_count += 1.
      ENDIF.
    ENDWHILE.

    result = candidate.
  ENDMETHOD.

  METHOD is_prime.
    DATA(num) = i_num.
    
    " Handle special cases
    IF num <= 1.
      RETURN.
    ENDIF.
    
    IF num = 2.
      r_prime = abap_true.
      RETURN.
    ENDIF.
    
    IF num MOD 2 = 0.
      RETURN.
    ENDIF.

    " Check odd divisors up to sqrt(num)
    DATA(limit) = sqrt( num ).
    DATA(divisor) = 3.
    
    WHILE divisor <= limit.
      IF num MOD divisor = 0.
        RETURN.  " Not prime
      ENDIF.
      divisor += 2.
    ENDWHILE.

    r_prime = abap_true.
  ENDMETHOD.
ENDCLASS.
