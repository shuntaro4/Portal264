Rails.application.routes.draw do
    root to: "welcome#index"
    get    "concerts",          to: "concerts#index",  as: "concerts_index"
    get    "concerts/new",      to: "concerts#new",    as: "concerts_new"
    get    "concerts/:id",      to: "concerts#show",   as: "concerts_show"
    get    "concerts/:id/edit", to: "concerts#edit",   as: "concerts_edit"
    post   "concerts/new",      to: "concerts#create", as: "concerts_create"
    delete "concerts/:id",      to: "concerts#delete", as: "concerts_destroy"
end
