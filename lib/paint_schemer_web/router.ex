defmodule PaintSchemerWeb.Router do
  use PaintSchemerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :admin do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:put_layout, {PaintSchemerWeb.LayoutView, :adminlayout})
  end

  scope "/", PaintSchemerWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)

    scope "/scheme", Scheme do
      get("/new", NewController, :index)
      get("/edit/:id", EditController, :index)
    end
  end

  scope "/admin", PaintSchemerWeb do
    pipe_through(:admin)
    get("/", AdminController, :index)
    get("/users", AdminController, :index)
    get("/paints", AdminController, :index)
  end

  # Other scopes may use custom stacks.
  scope "/api", PaintSchemerWeb do
    pipe_through(:api)
    resources("/paints", PaintController, except: [:new, :edit, :update])
    resources("/paint_types", PaintTypeController, except: [:new, :edit, :update])
    resources("/paint_manufacturers", ManufacturerController, except: [:new, :edit, :update])
    resources("/paint_techniques", PaintTechniqueController, except: [:new, :edit, :update])

    resources("/schemes", SchemeController, except: [:new, :edit])
  end
end
