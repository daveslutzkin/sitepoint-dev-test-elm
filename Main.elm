import StartApp
import Counter exposing (model, view, update)

main =
  StartApp.start { model = model, view = view, update = update }
