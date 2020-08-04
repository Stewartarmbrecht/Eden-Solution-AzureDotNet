using Newtonsoft.Json;

namespace MyEdenSolution.Text.Services.Models.Requests
{
    public class CreateTextRequest
    {
        [JsonProperty("text")]
        public string Text;

        [JsonProperty("categoryId")]
        public string CategoryId;
    }
}