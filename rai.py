import json
import random

def load_conversations(file_path):
    with open(file_path, 'r') as file:
        data = json.load(file)
    return data["questions"]

def get_response(question, conversations):
    for conv in conversations:
        if conv["question"].lower() == question.lower():
            return random.choice(conv["response"])
    return "Sorry, I didn't understand that."

def main():
    file_path = "./data/convo.json"
    conversations = load_conversations(file_path)
    
    while True:
        user_input = input("You: ")
        if user_input.lower() == "exit":
            print("Exiting...")
            break
        response = get_response(user_input, conversations)
        print("Bot:", response)
        print("\n")

if __name__ == "__main__":
    main()
