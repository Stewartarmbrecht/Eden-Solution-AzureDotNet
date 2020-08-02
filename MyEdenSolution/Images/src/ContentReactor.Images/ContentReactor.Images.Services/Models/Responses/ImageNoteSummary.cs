﻿using Newtonsoft.Json;

namespace MyEdenSolution.Images.Services.Models.Responses
{
    public class ImageNoteSummary
    {
        [JsonProperty("id")]
        public string Id { get; set; }
        
        [JsonProperty("preview")]
        public string Preview { get; set; }
    }
}
