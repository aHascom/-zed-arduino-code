; Arduino constants
((identifier) @constant
  (#match? @constant "^(HIGH|LOW|INPUT|OUTPUT|INPUT_PULLUP|INPUT_PULLDOWN|LED_BUILTIN)$"))

; Arduino built-in functions
((identifier) @function.builtin
  (#match? @function.builtin "^(pinMode|digitalWrite|digitalRead|analogWrite|analogRead|delay|delayMicroseconds|millis|micros|setup|loop|tone|noTone|pulseIn|pulseInLong|shiftIn|shiftOut|attachInterrupt|detachInterrupt|interrupts|noInterrupts|map|constrain|random|randomSeed|min|max|abs|sq|sqrt|sin|cos|tan)$"))

; Arduino types
((type_identifier) @type.builtin
  (#match? @type.builtin "^(boolean|byte|word|String)$"))
