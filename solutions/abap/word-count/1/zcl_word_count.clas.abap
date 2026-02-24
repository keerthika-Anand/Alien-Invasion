CLASS zcl_word_count DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    TYPES:
      BEGIN OF return_structure,
        word  TYPE string,
        count TYPE i,
      END OF return_structure,
      return_table TYPE STANDARD TABLE OF return_structure WITH KEY word.
    METHODS count_words
      IMPORTING
        !phrase       TYPE string
      RETURNING
        VALUE(result) TYPE return_table .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.
CLASS zcl_word_count IMPLEMENTATION.
  METHOD count_words.
    phrase = to_lower( phrase ).
    phrase = replace( val = phrase sub = '\n' with = | | occ = 0 ).
    phrase = replace( val = phrase sub = '\t' with = | | occ = 0 ).
    phrase = replace( val = phrase sub = ',' with = | | occ = 0 ).
    phrase  = replace( val = phrase regex = '[^a-z0-9 ]' with = '' occ = 0 ).
    SPLIT phrase AT ' ' INTO TABLE DATA(words).
    LOOP AT words ASSIGNING FIELD-SYMBOL(<word>).
      CHECK <word> IS NOT INITIAL.
      READ TABLE result ASSIGNING FIELD-SYMBOL(<res>) WITH KEY word = <word>.
      IF sy-subrc EQ 0.
        <res>-count += 1.
      ELSE.
       APPEND VALUE #( word = <word> count = 1 ) TO result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.