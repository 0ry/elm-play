import Html exposing (Html, div, h1, text, button, img)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, src)
import Random exposing (..)
import Svg exposing (Svg, svg, circle, rect)
import Svg.Attributes exposing (x, y, width, height, viewBox, cx, cy, r, visibility, fillOpacity, display)

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
    , div [] [ dieFace model.die1
             , dieFace model.die2
             ]
    , div [] [ button [ onClick Roll ] [ text "Roll" ] ]
    ]

type alias Circ =
    { cx : String
    , cy : String
    , r : String
    , pt : Point
    , v : Int
    }

dieFace : Int -> Html msg
dieFace value =
    svg [ width "120", height "120", viewBox "0 0 120 120", display "inline-block" ]
        [ rect [ x "1", y "1", width "128", height "128", fillOpacity "0.1" ] []
        , circ ("20", "20", "15", Corner1, value)
        , circ ("20", "20", "15", Corner1, value)
        , circ ("100", "20", "15", Corner2, value)
        , circ ("20", "60", "15", Side, value)
        , circ ("60", "60", "15", Center, value)
        , circ ("100", "60", "15", Side, value)
        , circ ("20", "100", "15", Corner2, value)
        , circ ("100", "100", "15", Corner1, value)
        ]


type Point
    = Corner1
    | Corner2
    | Side
    | Center

circ : (String, String, String, Point, Int) -> Svg msg
circ (cx_, cy_, r_, pt, v) =
    circle [ cx cx_, cy cy_, r r_, visibility (checkPoint pt v)] []

visible : Bool -> String
visible test =
    if test then "visible" else "hidden"

checkPoint : Point -> Int -> String
checkPoint point value =
    case point of
        Corner1 ->
            visible (value > 3)

        Corner2 ->
            visible (value /= 1)

        Side ->
            visible (value == 6)

        Center ->
            visible (value % 2 == 1)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

init : (Model, Cmd Msg)
init =
    (Model 6 6 False, Cmd.none)