defmodule VinculiDb.Repo.Migrations.RemoveWebsiteFromUserTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :website_url
    end
  end
end
