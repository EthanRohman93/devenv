import openai
import os
import sys

class AiRunner:
    def __init__(self, api_key):
        self.api_key = api_key
        openai.api_key = self.api_key

    def read_file(self, file_path):
        try:
            with open(file_path, 'r') as file:
                return file.read()
        except IOError as e:
            print(f"Error reading file {file_path}: {e}", file=sys.stderr)
            return None

    def write_file(self, file_path, content):
        try:
            with open(file_path, 'w') as file:
                file.write(content)
            return 0
        except IOError as e:
            print(f"Error writing file {file_path}: {e}", file=sys.stderr)
            return 1
        

    def build_messages(self, system, user):
        messages = [
            {
                "role": "system",
                "content": system
            },
            {
                "role": "user",
                "content": user
            }
        ]
        return messages

    def chat(self, messages):
        try:
            response = openai.chat.completions.create(
                model = "gpt-4o",
                messages = messages
            )
            return response
        except Exception as e:
            print(f"Error with OpenAI API request: {e}", file=sys.stderr)
            return None

    def chat_runner(self):
        system = self.read_file("~/.devenv/.system.md")
        user = self.read_file("~/.devenv/.user.md")
        if system is None or user is None:
            return 1
        messages = self.build_messages(system, user)
        response = self.chat(messages)
        if response is None:
            return 1
        return self.write_file("~/.devenv/.response.md", response)


def main():
    api_key = os.getenv("OPENAI_API_KEY")
    if api_key is None:
        print("API key not found.")
        sys.exit(1)
    runner = AiRunner(api_key)
    status = runner.chat_runner()
    if status != 0:
        print("Process completed with errors.", file=sys.stderr)
    else:
        print("Process completed successfully.", file=sys.stdout)
    sys.exit(status)


if __name__ == "__main__":
    main()
