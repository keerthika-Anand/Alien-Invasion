CLASS zcl_rle DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS encode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

    METHODS decode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

ENDCLASS.

CLASS zcl_rle IMPLEMENTATION.

  METHOD encode.

    DATA lv_ns TYPE string.

    DATA(lv_length) = strlen( input ).

    IF lv_length EQ 0.
      RETURN.
    ENDIF.

    DATA(lv_prev) = substring( val = input off = 0 len = 1 ).

    DATA(lv_i) = 1.
    DATA(lv_n) = 1.

    WHILE lv_i < lv_length.

      DATA(lv_this) = substring( val = input off = lv_i len = 1 ).

      IF lv_this EQ lv_prev.
        lv_n = lv_n + 1.
      ELSE.
        IF lv_n GT 1.
          lv_ns = lv_n.
          CONDENSE lv_ns NO-GAPS.
          CONCATENATE result lv_ns lv_prev INTO result.
        ELSE.
          CONCATENATE result lv_prev INTO result.
        ENDIF.

        lv_n = 1.
        lv_ns = ``.

      ENDIF.

      lv_prev = lv_this.
      ADD 1 TO lv_i.

    ENDWHILE.

    IF lv_n GT 1.
      lv_ns = lv_n.
      CONDENSE lv_ns NO-GAPS.
      CONCATENATE result lv_ns lv_prev INTO result.
    ELSE.
      CONCATENATE result lv_prev INTO result.
    ENDIF.

  ENDMETHOD.

  METHOD decode.

    DATA lv_ns TYPE string.

    DATA(lv_length) = strlen( input ).

    IF lv_length EQ 0.
      RETURN.
    ENDIF.

    DATA(lv_i) = 0.
    DATA(lv_n) = 1.

    WHILE lv_i < lv_length.

      DATA(lv_c) = substring( val = input off = lv_i len = 1 ).

      IF lv_c CA '0123456789'.

        CONCATENATE lv_ns lv_c INTO lv_ns.

      ELSE.

        IF strlen( lv_ns ) GT 0.
          lv_n = lv_ns.
          CLEAR lv_ns.
        ENDIF.

        DO lv_n TIMES.
          CONCATENATE result lv_c INTO result RESPECTING BLANKS.
        ENDDO.

        lv_n = 1.

      ENDIF.

      ADD 1 TO lv_i.

    ENDWHILE.

  ENDMETHOD.

ENDCLASS.