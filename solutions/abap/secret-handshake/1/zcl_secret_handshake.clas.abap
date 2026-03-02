CLASS zcl_secret_handshake DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_commands
      IMPORTING code            TYPE i
      RETURNING VALUE(commands) TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_secret_handshake IMPLEMENTATION.

  METHOD get_commands.
    DATA: lv_code     TYPE i VALUE code,
          lv_bit      TYPE i,
          lt_actions  TYPE string_table,
          lv_action   TYPE string,
          lv_reverse  TYPE abap_bool.

    " Process bits from LSB to MSB (right to left)
    DO 5 TIMES.
      lv_bit = lv_code MOD 2.
      lv_code = lv_code DIV 2.
      
      " Simple if-chain for bit positions (1st iteration = bit0, 2nd = bit1, etc)
      IF sy-index = 1 AND lv_bit = 1.  " Bit 0 - wink
        lv_action = 'wink'.
        APPEND lv_action TO lt_actions.
      ELSEIF sy-index = 2 AND lv_bit = 1.  " Bit 1 - double blink
        lv_action = 'double blink'.
        APPEND lv_action TO lt_actions.
      ELSEIF sy-index = 3 AND lv_bit = 1.  " Bit 2 - close your eyes
        lv_action = 'close your eyes'.
        APPEND lv_action TO lt_actions.
      ELSEIF sy-index = 4 AND lv_bit = 1.  " Bit 3 - jump
        lv_action = 'jump'.
        APPEND lv_action TO lt_actions.
      ELSEIF sy-index = 5 AND lv_bit = 1.  " Bit 4 - reverse
        lv_reverse = abap_true.
      ENDIF.
    ENDDO.

    " Reverse if needed (bit 4 was set)
    IF lv_reverse = abap_true.
      DATA: lv_temp TYPE string_table,
            lv_idx  TYPE i,
            lv_count TYPE i.
      
      DESCRIBE TABLE lt_actions LINES lv_count.
      
      DO lv_count TIMES.
        lv_idx = lv_count - sy-index + 1.
        READ TABLE lt_actions INDEX lv_idx INTO lv_action.
        APPEND lv_action TO lv_temp.
      ENDDO.
      
      lt_actions[] = lv_temp[].
    ENDIF.

    commands[] = lt_actions[].

  ENDMETHOD.

ENDCLASS.
