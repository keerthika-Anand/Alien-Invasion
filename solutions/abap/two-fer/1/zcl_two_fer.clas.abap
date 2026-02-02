CLASS zcl_two_fer DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS two_fer
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_two_fer IMPLEMENTATION.

  METHOD two_fer.
    DATA : lv_name TYPE string.

    IF input IS INITIAL.
      lv_name = 'you'.
    ELSE.
      lv_name = input.
    ENDIF.

    result = |One for { lv_name }, one for me.|.
           
  ENDMETHOD.

ENDCLASS.
