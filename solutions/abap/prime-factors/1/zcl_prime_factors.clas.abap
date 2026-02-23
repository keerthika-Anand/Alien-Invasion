CLASS zcl_prime_factors DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS factors
      IMPORTING
        input         TYPE int8
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_prime_factors IMPLEMENTATION.
  METHOD factors.
    DATA: lv_n TYPE int8 VALUE input,
          lv_d TYPE int8 VALUE 2.

    WHILE lv_n > 1.
      " Divide by current divisor as long as possible
      WHILE lv_n MOD lv_d = 0.
        APPEND lv_d TO result.
        lv_n = lv_n DIV lv_d.
      ENDWHILE.

      " Increment divisor: after 2, skip evens by adding 2
      lv_d = COND #( WHEN lv_d = 2 THEN 3 ELSE lv_d + 2 ).
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.
