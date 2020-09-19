module BloomRemit2
  class Agent
    class << self
      # Show a list of agents belonging to this partner
      def list
        agents = Client.get(path)
        agents.map do |agent|
          agent = agent.with_indifferent_access
          new(
            agent[:id],
            agent[:name],
            agent[:deleted_at]
          )
        end
      end

      # Show an agent belonging to this partner
      # @param id [String] agent uuid to retrieve details for
      def retrieve(id)
        agent = Client.get("#{path}/#{id}").with_indifferent_access
        new(
          agent[:id],
          agent[:name]
        )
      end

      # Create a new agent under this partner
      # @param name [String] agent name
      def create(name)
        agent = Client.post(path, { agent: { name: name }}).with_indifferent_access
        new(
          agent[:id],
          agent[:name]
        )
      end

      # TODO: Doesn't work at the moment
      # Update the attributes of an agent belonging to this partner
      # @param agent_id [String] agent uuid to update details for
      # @param name [String]
      # def update(agent_id, name:)
      #   result = Client.put(path, { agent: { name: name }})
      #   agent = JSON.parse(result).with_indifferent_access
      #   new(
      #     agent[:id],
      #     agent[:name]
      #   ) 
      # end

      # Delete an agent belonging to this partner
      # @param agent_id [String] agent uuid to delete
      def delete(agent_id)
        message = Client.delete("#{path}/#{agent_id}").with_indifferent_access
        if message[:success] == "We've successfully deleted that agent."
          new(
            agent_id,
            nil,
            deleted: true
          )
        end
      end

      private

      def path
        "api/v1/partners/#{BloomRemit2.configuration.api_token}/agents"
      end
    end

    attr_reader :id, :name, :deleted_at, :deleted

    def initialize(
      id,
      name,
      deleted_at=nil,
      deleted: false
    )
      @id = id
      @name = name
      @deleted_at = deleted_at
      @deleted = deleted
    end
  end
end
