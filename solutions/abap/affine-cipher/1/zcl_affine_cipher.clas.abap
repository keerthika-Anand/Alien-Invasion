CLASS zcl_affine_cipher DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF key,
             a TYPE i,
             b TYPE i,
           END OF key.

    METHODS:
      encode IMPORTING phrase        TYPE string
                       key           TYPE key
             RETURNING VALUE(cipher) TYPE string
             RAISING   cx_parameter_invalid,
      decode IMPORTING cipher        TYPE string
                       key           TYPE key
             RETURNING VALUE(phrase) TYPE string
             RAISING   cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_affine_cipher IMPLEMENTATION.
  METHOD encode.
    TYPES: ty_alfa TYPE TABLE OF c WITH EMPTY KEY.
    DATA lv_idx TYPE i.
    DATA: lv_txt TYPE string.


    DATA(lt_alfa) = VALUE ty_alfa(
        ( 'a' ) ( 'b' ) ( 'c' ) ( 'd' ) ( 'e' ) ( 'f' ) ( 'g' ) ( 'h' )
        ( 'i' ) ( 'j' ) ( 'k' ) ( 'l' ) ( 'm' ) ( 'n' ) ( 'o' ) ( 'p' )
        ( 'q' ) ( 'r' ) ( 's' ) ( 't' ) ( 'u' ) ( 'v' ) ( 'w' ) ( 'x' )
        ( 'y' ) ( 'z' )
    ).

    DATA(lv_phrase) = to_lower( phrase ).
    REPLACE ALL OCCURRENCES OF REGEX '[^0-9a-zA-Z]+' IN lv_phrase WITH ''.
    WHILE lv_idx < strlen( lv_phrase ).
      READ TABLE lt_alfa INTO DATA(ls_alfa) WITH KEY table_line = lv_phrase+lv_idx(1).
      IF sy-subrc = 0.
        DATA(lv_mod) = key-a MOD 26.
        IF lv_mod = 0.
          RAISE EXCEPTION TYPE cx_parameter_invalid.
        ELSE.
          lv_mod = key-a MOD 2.
          IF  lv_mod = 0.
            RAISE EXCEPTION TYPE cx_parameter_invalid.
          ENDIF.
        ENDIF.

        DATA(lv_letter_idx) = ( key-a * ( sy-tabix - 1 ) + key-b ) MOD 26.

        READ TABLE lt_alfa INDEX ( lv_letter_idx + 1 ) INTO ls_alfa.
        IF sy-subrc = 0.
          CONCATENATE cipher ls_alfa INTO cipher.
        ENDIF.
      ELSEIF lv_phrase+lv_idx(1) CO '0123456789'.
        CONCATENATE cipher  lv_phrase+lv_idx(1) INTO cipher.

      ENDIF.

      ADD 1 TO lv_idx.
      CHECK lv_idx NE strlen( lv_phrase ).
      CLEAR lv_mod.
      lv_mod = lv_idx MOD 5.  
      IF lv_mod = 0.
        CONCATENATE cipher space INTO cipher RESPECTING BLANKS.
      ENDIF.
    ENDWHILE.

  ENDMETHOD.

  METHOD decode.
    TYPES: ty_alfa TYPE TABLE OF c WITH EMPTY KEY.
    DATA: lv_idx TYPE i.
    DATA: lv_txt TYPE string,
          lv_mmi TYPE i.

    DATA(lt_alfa) = VALUE ty_alfa(
        ( 'a' ) ( 'b' ) ( 'c' ) ( 'd' ) ( 'e' ) ( 'f' ) ( 'g' ) ( 'h' )
        ( 'i' ) ( 'j' ) ( 'k' ) ( 'l' ) ( 'm' ) ( 'n' ) ( 'o' ) ( 'p' )
        ( 'q' ) ( 'r' ) ( 's' ) ( 't' ) ( 'u' ) ( 'v' ) ( 'w' ) ( 'x' )
        ( 'y' ) ( 'z' )
    ).

    DATA(lv_mod) = 26 mod key-a.
    IF lv_mod = 0.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ELSE.
      lv_mod = key-a MOD 2.
      IF  lv_mod = 0.
        RAISE EXCEPTION TYPE cx_parameter_invalid.
      ENDIF.
    ENDIF.

    CLEAR lv_mod.
    WHILE lv_mod NE 1.
      ADD 1 TO lv_mmi.
      lv_mod = ( key-a * lv_mmi ) MOD 26.
    ENDWHILE.

    WHILE lv_idx < strlen( cipher ).
      READ TABLE lt_alfa INTO DATA(ls_alfa) WITH KEY table_line = cipher+lv_idx(1).
      IF sy-subrc = 0.
        DATA(lv_y) = sy-tabix - 1.

        DATA(lv_dec_idx) = lv_mmi * ( lv_y - key-b ) MOD 26.

        READ TABLE lt_alfa INDEX ( lv_dec_idx + 1 ) INTO ls_alfa.
        IF sy-subrc = 0.
          CONCATENATE phrase ls_alfa INTO phrase.
        ENDIF.
      ELSEIF cipher+lv_idx(1) CO '0123456789'.
        CONCATENATE phrase  cipher+lv_idx(1) INTO phrase.
      ENDIF.

      ADD 1 TO lv_idx.
    ENDWHILE.
  ENDMETHOD.
ENDCLASS.