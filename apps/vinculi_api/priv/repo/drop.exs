# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     VinculiApi.Repo.insert!(%VinculiApi.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

cql_clean = "MATCH (n) DETACH DELETE n";

neo4j_conn = Bolt.Sips.begin(Bolt.Sips.conn)
Bolt.Sips.query!(neo4j_conn, cql_clean)
Bolt.Sips.commit(neo4j_conn)