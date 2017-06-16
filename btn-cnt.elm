module ButtonCounter exposing (Model, Msg, update, view, subscriptions, init)


import Html exposing (..)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
    }


type alias Model =
    { points : Int
    }


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Increment ->
            ( { model | points = model.points + 1 }, Cmd.none)

        Decrement ->
            ( { model | points = model.points + -1 }, Cmd.none)


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Increment ] [ text "+" ]
        , text ( toString model.points )
        , button [ onClick Decrement ] [ text "-" ]
        , div [] []
        , button [ onClick Increment ] [ text "+" ]
        , div [] [ text ( toString model.points ) ]
        , button [ onClick Decrement ] [ text "-" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : (Model, Cmd Msg)
init = 
    ( { points = 0 }, Cmd.none)
