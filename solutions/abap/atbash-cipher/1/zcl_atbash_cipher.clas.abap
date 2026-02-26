CLASS zcl_atbash_cipher DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS decode
      IMPORTING
        cipher_text TYPE string
      RETURNING
        VALUE(plain_text)  TYPE string .
    METHODS encode
      IMPORTING
        plain_text        TYPE string
      RETURNING
        VALUE(cipher_text) TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_atbash_cipher IMPLEMENTATION.

  METHOD decode.
    DATA: lv_temp TYPE string,
          lv_char TYPE c LENGTH 1,
          lv_mapped TYPE c LENGTH 1,
          lv_len TYPE i,
          lv_i TYPE i.

    lv_temp = cipher_text.
    lv_len = strlen( lv_temp ).
    CLEAR plain_text.

    DO lv_len TIMES.
      lv_i = sy-index - 1.
      lv_char = lv_temp+lv_i(1).

      IF lv_char >= 'a' AND lv_char <= 'z'.
        " Cipher to plain (reverse mapping)
        CASE lv_char.
          WHEN 'z'. lv_mapped = 'a'.
          WHEN 'y'. lv_mapped = 'b'.
          WHEN 'x'. lv_mapped = 'c'.
          WHEN 'w'. lv_mapped = 'd'.
          WHEN 'v'. lv_mapped = 'e'.
          WHEN 'u'. lv_mapped = 'f'.
          WHEN 't'. lv_mapped = 'g'.
          WHEN 's'. lv_mapped = 'h'.
          WHEN 'r'. lv_mapped = 'i'.
          WHEN 'q'. lv_mapped = 'j'.
          WHEN 'p'. lv_mapped = 'k'.
          WHEN 'o'. lv_mapped = 'l'.
          WHEN 'n'. lv_mapped = 'm'.
          WHEN 'm'. lv_mapped = 'n'.
          WHEN 'l'. lv_mapped = 'o'.
          WHEN 'k'. lv_mapped = 'p'.
          WHEN 'j'. lv_mapped = 'q'.
          WHEN 'i'. lv_mapped = 'r'.
          WHEN 'h'. lv_mapped = 's'.
          WHEN 'g'. lv_mapped = 't'.
          WHEN 'f'. lv_mapped = 'u'.
          WHEN 'e'. lv_mapped = 'v'.
          WHEN 'd'. lv_mapped = 'w'.
          WHEN 'c'. lv_mapped = 'x'.
          WHEN 'b'. lv_mapped = 'y'.
          WHEN 'a'. lv_mapped = 'z'.
        ENDCASE.
        plain_text = |{ plain_text }{ lv_mapped }|.
      ELSEIF lv_char >= '0' AND lv_char <= '9'.
        " Preserve numbers unchanged
        plain_text = |{ plain_text }{ lv_char }|.
      ENDIF.
    ENDDO.
  ENDMETHOD.

  METHOD encode.
    DATA: lv_temp TYPE string,
          lv_char TYPE c LENGTH 1,
          lv_mapped TYPE c LENGTH 1,
          lv_len TYPE i,
          lv_i TYPE i,
          lv_result TYPE string,
          lv_chunk TYPE string,
          lv_pos TYPE i.

    " Process ALL chars: cipher letters, keep numbers, exclude punctuation/spaces
    lv_temp = to_lower( plain_text ).
    lv_len = strlen( lv_temp ).
    CLEAR lv_result.

    DO lv_len TIMES.
      lv_i = sy-index - 1.
      lv_char = lv_temp+lv_i(1).
      
      IF lv_char >= 'a' AND lv_char <= 'z'.
        " Cipher letters only
        CASE lv_char.
          WHEN 'a'. lv_mapped = 'z'.
          WHEN 'b'. lv_mapped = 'y'.
          WHEN 'c'. lv_mapped = 'x'.
          WHEN 'd'. lv_mapped = 'w'.
          WHEN 'e'. lv_mapped = 'v'.
          WHEN 'f'. lv_mapped = 'u'.
          WHEN 'g'. lv_mapped = 't'.
          WHEN 'h'. lv_mapped = 's'.
          WHEN 'i'. lv_mapped = 'r'.
          WHEN 'j'. lv_mapped = 'q'.
          WHEN 'k'. lv_mapped = 'p'.
          WHEN 'l'. lv_mapped = 'o'.
          WHEN 'm'. lv_mapped = 'n'.
          WHEN 'n'. lv_mapped = 'm'.
          WHEN 'o'. lv_mapped = 'l'.
          WHEN 'p'. lv_mapped = 'k'.
          WHEN 'q'. lv_mapped = 'j'.
          WHEN 'r'. lv_mapped = 'i'.
          WHEN 's'. lv_mapped = 'h'.
          WHEN 't'. lv_mapped = 'g'.
          WHEN 'u'. lv_mapped = 'f'.
          WHEN 'v'. lv_mapped = 'e'.
          WHEN 'w'. lv_mapped = 'd'.
          WHEN 'x'. lv_mapped = 'c'.
          WHEN 'y'. lv_mapped = 'b'.
          WHEN 'z'. lv_mapped = 'a'.
        ENDCASE.
        lv_result = |{ lv_result }{ lv_mapped }|.
      ELSEIF lv_char >= '0' AND lv_char <= '9'.
        " Keep numbers unchanged
        lv_result = |{ lv_result }{ lv_char }|.
      ENDIF.
    ENDDO.

    " Chunk the result (letters + numbers only)
    lv_len = strlen( lv_result ).
    CLEAR cipher_text.
    lv_pos = 0.
    
    WHILE lv_pos < lv_len.
      DATA(lv_chunk_len) = COND i( WHEN lv_len - lv_pos >= 5 THEN 5 ELSE lv_len - lv_pos ).
      lv_chunk = lv_result+lv_pos(lv_chunk_len).
      
      IF cipher_text IS INITIAL.
        cipher_text = lv_chunk.
      ELSE.
        cipher_text = |{ cipher_text } { lv_chunk }|.
      ENDIF.
      
      lv_pos = lv_pos + 5.
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.
