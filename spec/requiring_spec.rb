# frozen_string_literal: true

RSpec.describe "requiring files" do
  let(:paths) { Dir["./lib/**/*.rb"] }
  let(:failures) { [] }

  it "allows to require files separately" do
    Parallel.each(paths, in_threads: Parallel.processor_count) do |path|
      command = Shellwords.join(["bundle", "exec", "ruby", path])

      Open3.popen2e(command) do |_input, output, wait_thr|
        status = wait_thr.value
        failures << [command, output.read].join("\n") unless status.success?
      end
    end

    expect(failures.size)
      .to eq(0), "#{failures.join("#{"-" * 80}\n")}\n#{failures.size}/#{paths.size} files failed."
  end
end
