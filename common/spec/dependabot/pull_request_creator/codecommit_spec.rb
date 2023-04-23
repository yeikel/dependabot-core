# frozen_string_literal: true

require "spec_helper"
require "dependabot/dependency"
require "dependabot/dependency_file"
require "dependabot/pull_request_creator/github"

RSpec.describe Dependabot::PullRequestCreator::Codecommit do
  subject(:creator) do
    described_class.new(
      source: source,
      branch_name: branch_name,
      base_commit: base_commit,
      credentials: credentials,
      files: files,
      commit_message: commit_message,
      pr_description: pr_description,
      pr_name: pr_name,
      author_details: author_details,
      labeler: labeler,
      require_up_to_date_base: require_up_to_date_base
    )
  end

  context "the PR description is too long" do
    let(:pr_description) { "a" * (described_class::MAX_PR_DESCRIPTION_LENGTH + 1) }

    it "truncates the description" do
      creator.create

      expect(WebMock).
        to have_requested(:post, "#{repo_api_url}/pulls").
          with(
            body: {
              base: "master",
              head: "dependabot/bundler/business-1.5.0",
              title: "PR name",
              body: ->(body) { expect(body.length).to be <= described_class::MAX_PR_DESCRIPTION_LENGTH }
            }
          )
    end
  end
end
