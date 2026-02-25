CLASS zcl_difference_of_squares DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      ret_difference_of_squares IMPORTING num         TYPE i
                                RETURNING VALUE(diff) TYPE i,
      ret_sum_of_squares        IMPORTING num                   TYPE i
                                RETURNING VALUE(sum_of_squares) TYPE i,
      ret_square_of_sum         IMPORTING num                  TYPE i
                                RETURNING VALUE(square_of_sum) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_difference_of_squares IMPLEMENTATION.

  METHOD ret_difference_of_squares.
    diff = ret_square_of_sum( num ) - ret_sum_of_squares( num ).
  ENDMETHOD.

  METHOD ret_sum_of_squares.
    sum_of_squares = num * ( num + 1 ) * ( 2 * num + 1 ) / 6.
  ENDMETHOD.

  METHOD ret_square_of_sum.
    DATA(lv_sum) = num * ( num + 1 ) / 2.
    square_of_sum = lv_sum * lv_sum.
  ENDMETHOD.

ENDCLASS.
