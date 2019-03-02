module DataInitializable
  extend ActiveSupport::Concern

  #----------------------------------
  # Fix table sequence id
  # args     : string
  # returns  : none
  # note     :
  #   Use rails db:seed or rails spec in User Registrations.
  #   Call this if you get an error "ActiveRecord::RecordNotUnique in (...) PG::UniqueViolation: ERROR: duplicate key value violates unique constraint".
  #----------------------------------
  def fix_sequence_id(tablename)
    connection = ActiveRecord::Base.connection()
    connection.execute("select setval('#{tablename}_id_seq',(select max(id) from #{tablename}))")
  end
end
