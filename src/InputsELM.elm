module InputsELM exposing (..)
import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

--MAIN

main =
  Browser.sandbox { init = init, update = update, view = view }

--MODEL

type alias Model =
  {
    content : String,
    contentNormal : String
  }

init : Model
init =
  { content = "", contentNormal = "" }

--UPDATE

type Msg
    = Change String
    | Normal String

update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
          { model | content = newContent }

        Normal newContent ->
          { model | contentNormal = newContent}

--VIEW

view : Model -> Html Msg
view model =
    div[]
      [
        input [ placeholder "Text to reverse", value model.content, onInput Change ] []
        ,div[] [ text ( String.reverse model.content) ]
        ,input [ placeholder "Text", value model.contentNormal, onInput Normal] []
        ,div[] [ text ( model.contentNormal) ]
      ]