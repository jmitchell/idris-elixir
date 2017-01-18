module IRTS.CodegenElixir(codegenElixir) where

import IRTS.CodegenCommon

import Text.PrettyPrint
import Text.Show.Pretty

codegenElixir :: CodeGenerator
codegenElixir ci = writeFile (outputFile ci) (render source)
  where
    source = vcat sections
    sections =
      [ prelude
      , body
      , epilogue
      ]
    prelude = elixirComment "generated by idris-elixir"
    body = vcat
      [ elixirComment "SIMPLIFIED"
      , ppDoc simplified
      , blankLines 3
      , elixirComment "DEFUNCTIONALIZED"
      , ppDoc defunctionalized
      , blankLines 3
      , elixirComment "LAMBDA LIFTED"
      , ppDoc lambdaLifted
      ]
    epilogue = elixirComment "EOF (generated by idris-elixir)"

    -- need to use any one of these to generate code
    simplified = simpleDecls ci
    defunctionalized = defunDecls ci
    lambdaLifted = liftDecls ci

-- |Emit an Elixir-style comment (line beginning with '#').
-- Doesn't support multiple lines nor line wrapping.
elixirComment :: String -> Doc
elixirComment c = text $ "# " ++ c

blankLines :: Int -> Doc
blankLines n = text $ take (n-1) $ repeat '\n'

blank :: Doc
blank = blankLines 1
