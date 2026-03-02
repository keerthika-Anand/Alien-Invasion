CLASS zcl_isogram DEFINITION PUBLIC.

  PUBLIC SECTION.
    METHODS is_isogram
      IMPORTING
        VALUE(phrase)        TYPE string
      RETURNING
        VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_isogram IMPLEMENTATION.
  METHOD is_isogram.
    result = abap_true.
    DO strlen( phrase ) TIMES.
      DATA(pos)  = sy-index - 1.
      DATA(character) = to_upper( phrase+pos(1) ).
      IF sy-abcde cs character and count( val = to_upper( phrase ) regex = character ) > 1.
        result = abap_false.
        RETURN.
      ENDIF.
    ENDDO.
  ENDMETHOD.
ENDCLASS.