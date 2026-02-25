CLASS zcl_rna_transcription DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS
      transcribe
        IMPORTING
          strand             TYPE string
        RETURNING
          VALUE(result)      TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_rna_transcription IMPLEMENTATION.

  METHOD transcribe.
    DATA: lv_pos TYPE i,
          lv_char TYPE c LENGTH 1,
          lv_rna TYPE string.

    lv_pos = 0.
    CLEAR lv_rna.
    WHILE lv_pos < strlen( strand ).
      lv_char = strand+lv_pos(1).
      
      CASE lv_char.
        WHEN 'G'.
          lv_rna = lv_rna && 'C'.
        WHEN 'C'.
          lv_rna = lv_rna && 'G'.
        WHEN 'T'.
          lv_rna = lv_rna && 'A'.
        WHEN 'A'.
          lv_rna = lv_rna && 'U'.
        WHEN OTHERS.
          " Invalid nucleotide - leave unchanged or handle as needed
          lv_rna = lv_rna && lv_char.
      ENDCASE.
      
      lv_pos = lv_pos + 1.
    ENDWHILE.
    
    result = lv_rna.
  ENDMETHOD.

ENDCLASS.

