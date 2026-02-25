CLASS zcl_collatz_conjecture DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS ret_steps IMPORTING num          TYPE i
                      RETURNING VALUE(steps) TYPE i
                      RAISING   cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_collatz_conjecture IMPLEMENTATION.
  METHOD ret_steps.
    DATA: current TYPE i VALUE num.

    IF current <= 0.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    steps = 0.
    WHILE current <> 1.
      IF current MOD 2 = 0.
        current = current / 2.
      ELSE.
        current = current * 3 + 1.
      ENDIF.
      steps = steps + 1.
    ENDWHILE.
  ENDMETHOD.
ENDCLASS.
