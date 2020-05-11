-- Input a user name and password. Make sure the password matches.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/forms.html
--
module ValidacionContrasena exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

-- MAIN

main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL

type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }

init : Model
init =
  Model {name = "" password = "" passwordAgain = ""}

-- UPDATE

type Msg
  = Name String
  | Password String
  | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    , text (model.password)
    , text (model.passwordAgain)
    , viewValidation model
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

viewValidation : Model -> Html msg
viewValidation model =
  if model.password == model.passwordAgain then
    if String.length model.password >=8 then
      if String.any  Char.isUpper model.password then
        if String.any Char.isLower model.password then
          if String.any Char.isDigit model.password then
            div [ style "color" "green" ] [ text "Contraseña segura" ]
          else
            div [ style "color" "red" ] [ text "La contraseña debe tener al menos un número" ]
        else
          div [ style "color" "red" ] [ text "La contraseña debe tener al menos una minuscula"]
      else
         div [ style "color" "red" ] [ text "debe agregar minimo una mayuscula" ]
      --div [ style "color" "green" ] [ text "Contraseña segura" ]
    else
      div [ style "color" "red" ] [ text "La contraseña debe ser igual o mayor a 8 caracteres" ]
  else
    div [ style "color" "red" ] [ text "Passwords do not match!" ]
