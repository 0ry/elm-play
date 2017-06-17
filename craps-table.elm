import Html exposing (Html, div, h1, text, button, img)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Random exposing (..)

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

type alias Model =
    { die1 : Int
    , die2 : Int
    , isRolling : Bool
    }

type Msg
    = Roll
    | Throw Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Roll ->
            (model, Random.generate Throw (Random.int 1 6))
        
        Throw d ->
            if model.isRolling == True then
                ({ model
                    | die2 = d
                    , isRolling = False
                    }
                , Cmd.none)
            else
                ({ model
                    | die1 = d
                    , isRolling = True
                    }
                , Random.generate Throw (Random.int 1 6))

view : Model -> Html Msg
view model =
    div [ style [("margin", "30px")]]
    [ h1 [] [ text ((toString model.die1) ++ " and " ++ (toString model.die2)) ]
    , img [ src ("../images/die_" ++ (toString model.die1) ++ ".png") ] []
    , img [ src ("../images/die_" ++ (toString model.die2) ++ ".png") ] []
    , div [] [ button [ onClick Roll ] [ text "Roll" ] ]
    ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

init : (Model, Cmd Msg)
init =
    (Model 6 6 False, Cmd.none)