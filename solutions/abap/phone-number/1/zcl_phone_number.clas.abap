CLASS zcl_phone_number DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS clean
      IMPORTING
        !number       TYPE string
      RETURNING
        VALUE(result) TYPE string
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_phone_number IMPLEMENTATION.

  METHOD clean.
    DATA: cleaned TYPE string.

    " Remove all non-digit characters
    cleaned = replace( val = to_upper( number ) regex = '[^0-9]' with = '' occ = 0 ).

    " Handle country code
    IF strlen( cleaned ) = 11 AND cleaned(1) = '1'.
      cleaned = cleaned+1.
    ENDIF.

    " Validate length and invalid area/exchange codes
    IF strlen( cleaned ) <> 10 OR
       cleaned+0(3) CA '0|1' OR
       cleaned+3(3) CA '0|1'.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    result = cleaned.
  ENDMETHOD.

ENDCLASS.
