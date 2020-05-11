-- Show the current time in your time zone.
--
-- Read how it works:
--   https://guide.elm-lang.org/effects/time.html
--
-- For an analog clock, check out this SVG example:
--   https://elm-lang.org/examples/clock
--

module TimeExercise exposing (..)
import Html exposing (Html, button, text, h1, div)
import Html.Events exposing (onClick)
import Browser
import Task
import Time
import Svg exposing(..)
import Svg.Attributes exposing(..)


-- MAIN


main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { zone : Time.Zone
  , time : Time.Posix
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model Time.utc (Time.millisToPosix 0)
  , Task.perform AdjustTimeZone Time.here
  )



-- UPDATE


type Msg
  = Tick Time.Posix
  | AdjustTimeZone Time.Zone
  | Parar Time.Posix



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      ( { model | time = newTime }
      , Cmd.none
      )

    AdjustTimeZone newZone ->
      ( { model | zone = newZone }
      , Cmd.none
      )

    Parar newTiempo ->
      ( { model | time = newTiempo }
      , Cmd.none
      )



-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every 1000 Tick

-- VIEW

view : Model -> Html Msg
view model =
  let
    hour   = String.fromInt (Time.toHour   model.zone model.time)
    minute = String.fromInt (Time.toMinute model.zone model.time)
    second = String.fromInt (Time.toSecond model.zone model.time)
  in
  -- div []
   h1 [] [ Html.text (hour ++ ":" ++ minute ++ ":" ++ second) ]
    -- ,button [ onClick Parar ] [ Html.text "Stop"]
