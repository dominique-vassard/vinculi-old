defmodule VinculiDb.Repo.Migrations.AddWebsiteUser do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add :website_url, :string

      modify :first_name, :string, null: true
      modify :last_name, :string, null: true
    end
  end

  def down do
    alter table(:users) do
      remove :website_url

      modify :first_name, :string, null: false
      modify :last_name, :string, null: false
    end
  end
end
