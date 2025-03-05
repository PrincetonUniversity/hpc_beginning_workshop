import os
import requests
import json
import base64
from mimetypes import guess_type
from openai import AzureOpenAI
 
# Before executing this code, define the API Key within an environment
# variable in your OS
# Linux BASH example: export AI_SANDBOX_KEY=
 
# Import API key from OS environment variables
sandbox_api_key=os.environ['AI_SANDBOX_KEY']
 
# Set the URL of the AI Sandbox API
sandbox_endpoint="https://api-ai-sandbox.princeton.edu/"
sandbox_api_version="2024-02-01"
 
# Set the model deployment name that the prompt should be sent to
available_models = [
                    "gpt-4o",
                    "gpt-35-turbo-16k",
                    "Meta-Llama-3-1-70B-Instruct-htzs",
                    "Meta-Llama-3-1-8B-Instruct-nwxcg",
                    "Mistral-small-zgjes",
                    "Mistral-large-ygkys"
                   ]
 
# Base 64 encode local image and return text to be included in JSON request
def local_image_to_data_url(image_path):
    """
    Get the url of a local image
    """
    mime_type, _ = guess_type(image_path)
 
    if mime_type is None:
        mime_type = "application/octet-stream"
 
    with open(image_path, "rb") as image_file:
        base64_encoded_data = base64.b64encode(image_file.read()).decode("utf-8")
 
    return f"data:{mime_type};base64,{base64_encoded_data}"


# This function will submit a simple text prompt to the chosen model
def text_prompt_example(model_to_be_used):
    # Establish a connection to your Azure OpenAI instance
    client = AzureOpenAI(
        api_key=sandbox_api_key,
        azure_endpoint = sandbox_endpoint,
        api_version=sandbox_api_version # current api version not in preview
    )
 
    # temperature = how creative/random the model is in generating response;
    #               0 to 1 with 1 being most creative
    # max_tokens = token limit on context to send to the model
    # top_p = diversity of generated text by the model considering probability
    #         attached to token; 0 to 1 - ex. top_p of 0.1 = only tokens within
    #         the top 10% probability are considered
    response = client.chat.completions.create(
               model=model_to_be_used,
               temperature=0.5, 
               max_tokens=1000, 
               top_p=0.5,
               messages=[
                         {"role": "system",
                          "content": "You are a helpful junior physics professor."},
                         {"role": "user",
                          "content": "Please explain quantum mechanics in 100 words or less."},
                         ])
 
    print("\n"+response.choices[0].message.content)
 
# This function will ask the model to describe what is in the given image
# NOTE:  I tried using the client.chat.completions.create() function for this, 
# but it resulted in HTTP 431 "Too many headers" errors.
# In order to reduce the number of HTTP headers I switched to 
# submitting JSON directly to the API using a requests.post() function.
def image_prompt_example(model_to_be_used, image_file):
    headers = {
               'api-key': sandbox_api_key,
               'Content-Type': 'application/json'
              }
 
    data = {
             "messages": [{"role": "system",
                           "content": "You are a helpful assistant to analyse images."},
                          {"role": "user",
                           "content": [{"type": "text", "text": "What is in this image?"},
                          {"type": "image_url",
                           "image_url": {"url":local_image_to_data_url(image_file)}}]}],
             "model": model_to_be_used,
             "max_tokens": 2000,
             "temperature": 0.0
            }
 
    # Generate JSON object
    try:
        # Convert dictionary to JSON string
        json_data = json.dumps(data)
        # Parse JSON string to validate
        parsed_data = json.loads(json_data)
    except json.JSONDecodeError as e:
        print("Invalid JSON, unable to create JSON object:", e)
        exit(-1)
 
    endpoint = sandbox_endpoint + "openai/deployments/" + \
               model_to_be_used + "/chat/completions?api-version=" + \
               sandbox_api_version
 
    response = requests.post(endpoint, data=json_data, headers=headers)
    #print(response.text)
 
    json_response = json.loads(response.text)
    print("\n"+json_response['choices'][0]['message']['content'])


# Execute the example functions
if __name__ == "__main__":
 
    # Execute the text example
    text_prompt_example(available_models[0])
  
    # Execute the image example
    image_file = "/path/to/image/file.jpg"
    image_prompt_example(available_models[0],image_file)
