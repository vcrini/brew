require "cmd/info"

describe "brew info", :integration_test do
  before do
    setup_test_formula "testball"
  end

  it "prints information about a given Formula" do
    expect { brew "info", "testball" }
      .to output(/testball: stable 0.1/).to_stdout
      .and not_to_output.to_stderr
      .and be_a_success
  end

  it "prints as json with the --json=v1 flag" do
    expect { brew "info", "testball", "--json=v1" }
      .to output(a_json_string).to_stdout
      .and not_to_output.to_stderr
      .and be_a_success
  end
end

describe Homebrew do
  let(:remote) { "https://github.com/vcrini/homebrew-core" }

  specify "::github_remote_path" do
    expect(subject.github_remote_path(remote, "Formula/git.rb"))
      .to eq("https://github.com/vcrini/homebrew-core/blob/master/Formula/git.rb")

    expect(subject.github_remote_path("#{remote}.git", "Formula/git.rb"))
      .to eq("https://github.com/vcrini/homebrew-core/blob/master/Formula/git.rb")

    expect(subject.github_remote_path("git@github.com:user/repo", "foo.rb"))
      .to eq("https://github.com/user/repo/blob/master/foo.rb")

    expect(subject.github_remote_path("https://mywebsite.com", "foo/bar.rb"))
      .to eq("https://mywebsite.com/foo/bar.rb")
  end
end
