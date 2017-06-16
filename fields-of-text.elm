
module ReverseString exposing (Model, Msg, update, view, subscriptions, init)


import Html exposing (Html, Attribute, div, input, text, h3)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
    }


type alias Model =
    { content : String
    }


type Msg
    = Change String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Change newContent ->
            ( { model | content = newContent }, Cmd.none)


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text (String.reverse model.content) ]
        , input [ placeholder "Text to reverse", onInput Change ] []
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : (Model, Cmd Msg)
init = 
    ( { content = "Text to reverse" }, Cmd.none)

