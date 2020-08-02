using Newtonsoft.Json;

namespace MyEdenSolution.Images.Services.Models.Requests
{
    public class CompleteCreateImageRequest
    {
        [JsonProperty("categoryId")]
        public string CategoryId { get; set; }
    }
}