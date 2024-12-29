import openai
import sys
import os

openai.api_key = os.getenv("OPENAI_API_KEY")

def ask_openai(question, code=None):
    prompt = question
    if code:
        prompt += f"\n\nHere is the code:\n{code}"
    response = openai.chat.completions.create(
        model="gpt-4o",
        messages=[
            {"role": "system", "content": "You are a helpful computer science assistant and you will not output more than 50 tokens per response"},
            {"role": "user", "content": prompt}
        ]
    )
    return response.choices[0].message.content

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python openai_query.py <question> [<code_file>]")
        sys.exit(1)
    question = sys.argv[1]
    code = None
    if len(sys.argv) == 3:
        code_file = sys.argv[2]
        try:
            with open(code_file, 'r') as f:
                code = f.read()
        except Exception as e:
            print(f"Error reading code file: {e}")
            sys.exit(1)
    answer = ask_openai(question, code)
    print(f"OpenAI: {answer}")
