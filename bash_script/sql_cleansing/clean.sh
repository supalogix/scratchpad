#!/bin/bash

gsed -i 's/--[[:space:]]*\(DROP TRIGGER.*;\)/\1/g' anchor_model.sql 
gsed -i 's/--[[:space:]]*\(DROP FUNCTION.*;\)/\1/g' anchor_model.sql 
