
import Html exposing (Html, div, h2, text, img, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (src)

main : Program Never Model Msg
main = 
    Html.program 
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

type alias Model = 
    { topic : String
    , gifUrl : String
    }

type Msg
    = SetTopic String
    | ChangeUrl

view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.topic ]
        , img [ src model.gifUrl ] []
        , button [ onClick ChangeUrl ] [ text "Change Gif" ]
        ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SetTopic str ->
            ({ model | topic = str }, Cmd.none)

        ChangeUrl ->
            (model, Cmd.none)
            -- ({ model | gifUrl = str }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

init : (Model, Cmd Msg)
init =
    (Model "" "", Cmd.none)