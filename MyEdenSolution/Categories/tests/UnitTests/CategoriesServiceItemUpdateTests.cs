namespace MyEdenSolution.Categories.Tests.UnitTests
{
    using System.Linq;
    using System.Threading.Tasks;
    using MyEdenSolution.Categories.Services;
    using MyEdenSolution.Categories.Services.Models;
    using MyEdenSolution.Categories.Services.Models.Data;
    using MyEdenSolution.Common;
    using MyEdenSolution.Common.Events.Audio;
    using MyEdenSolution.Common.EventSchemas.Categories;
    using MyEdenSolution.Common.EventSchemas.Text;
    using MyEdenSolution.Common.Events;
    using Microsoft.Extensions.Localization;
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using Moq;

    /// <summary>
    /// Contains all unit tests for the Categories service update item event processing operation.
    /// </summary>
    [TestClass]
    public class CategoriesServiceItemUpdateTests
    {
        /// <summary>
        /// Given you have a category service
        /// And the category service has a category
        /// And the category has a Text item preview
        /// When you do raise the TextUpdated event for that item
        /// Then the service should update the item preview.
        /// </summary>
        /// <returns>A task to run test.</returns>
        [TestMethod]
        public async Task ProcessUpdateItemEventAsyncUpdatesTextItem()
        {
            // arrange
            var fakeCategoriesRepository = new FakeCategoriesRepository();
            var category = new CategoryDocument
            {
                Id = "fakecategoryid",
                Name = "fakename",
                UserId = "fakeuserid",
            };
            category.Items.Add(new CategoryItem { Id = "fakeitemid", Type = ItemType.Text, Preview = "oldpreview" });

            fakeCategoriesRepository.CategoryDocuments.Add(category);

            var service = new CategoriesService(
                fakeCategoriesRepository,
                new Mock<IImageSearchService>().Object,
                new Mock<ISynonymService>().Object,
                new Mock<IEventGridPublisherService>().Object);

            var eventToProcess = new EventGridEvent
            {
                Subject = "fakeuserid/fakeitemid",
                EventType = TextEvents.TextUpdated,
                Data = new TextUpdatedEventData
                {
                    Preview = "newpreview"
                }
            };

            // act
            await service.ProcessUpdateItemEventAsync(eventToProcess, "fakeuserid").ConfigureAwait(false);

            // assert
            var itemsCollection = fakeCategoriesRepository.CategoryDocuments.Single().Items;
            Assert.AreEqual("newpreview", itemsCollection.Single().Preview);
        }

        /// <summary>
        /// Given you have a category service
        /// And the category service has a category
        /// And the category has a Audio item preview
        /// When you do raise the AudioTranscriptUpdated event for that item
        /// Then the service should update the item preview.
        /// </summary>
        /// <returns>A task to run test.</returns>
        [TestMethod]
        public async Task ProcessUpdateItemEventAsyncUpdatesAudioItem()
        {
            // arrange
            var fakeCategoriesRepository = new FakeCategoriesRepository();

            var category = new CategoryDocument
            {
                Id = "fakecategoryid",
                Name = "fakename",
                UserId = "fakeuserid",
            };

            category.Items.Add(new CategoryItem { Id = "fakeitemid", Type = ItemType.Audio, Preview = "oldpreview" });

            fakeCategoriesRepository.CategoryDocuments.Add(category);

            var service = new CategoriesService(
                fakeCategoriesRepository,
                new Mock<IImageSearchService>().Object,
                new Mock<ISynonymService>().Object,
                new Mock<IEventGridPublisherService>().Object);

            var eventToProcess = new EventGridEvent
            {
                Subject = "fakeuserid/fakeitemid",
                EventType = AudioEvents.AudioTranscriptUpdated,
                Data = new AudioTranscriptUpdatedEventData
                {
                    TranscriptPreview = "newpreview"
                }
            };

            // act
            await service.ProcessUpdateItemEventAsync(eventToProcess, "fakeuserid").ConfigureAwait(false);

            // assert
            var itemsCollection = fakeCategoriesRepository.CategoryDocuments.Single().Items;
            Assert.AreEqual("newpreview", itemsCollection.Single().Preview);
        }

        /// <summary>
        /// Given you have a category service
        /// And the category service has a category
        /// And the category has a Text item preview
        /// When you do raise the TextUpdated event for that item
        /// Then the service should raise the CategoryItemsUpdated event.
        /// </summary>
        /// <returns>A task to run test.</returns>
        [TestMethod]
        public async Task ProcessUpdateItemEventAsyncPublishesCategoryItemsUpdatedEventToEventGrid()
        {
            // arrange
            var fakeCategoriesRepository = new FakeCategoriesRepository();

            var category = new CategoryDocument
            {
                Id = "fakecategoryid",
                Name = "fakename",
                UserId = "fakeuserid",
            };

            category.Items.Add(new CategoryItem { Id = "fakeitemid", Type = ItemType.Text, Preview = "oldpreview" });

            fakeCategoriesRepository.CategoryDocuments.Add(category);

            var mockEventGridPublisherService = new Mock<IEventGridPublisherService>();

            var service = new CategoriesService(
                fakeCategoriesRepository,
                new Mock<IImageSearchService>().Object,
                new Mock<ISynonymService>().Object,
                mockEventGridPublisherService.Object);

            var eventToProcess = new EventGridEvent
            {
                Subject = "fakeuserid/fakeitemid",
                EventType = TextEvents.TextUpdated,
                Data = new TextUpdatedEventData
                {
                    Preview = "newpreview"
                }
            };

            // act
            await service.ProcessUpdateItemEventAsync(eventToProcess, "fakeuserid").ConfigureAwait(false);

            // assert
            mockEventGridPublisherService.Verify(
                m => m.PostEventGridEventAsync(
                    CategoryEvents.CategoryItemsUpdated,
                    "fakeuserid/fakecategoryid",
                    It.IsAny<CategoryItemsUpdatedEventData>()),
                Times.Once);
        }
    }
}
