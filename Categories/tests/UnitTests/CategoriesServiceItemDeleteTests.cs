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
    /// Contains all unit tests for the Categories service item delete event processing operation.
    /// </summary>
    [TestClass]
    public class CategoriesServiceItemDeleteTests
    {
        /// <summary>
        /// Given you have an instance of the category service
        /// And the category service has a category with a category item
        /// When you raise the TextDeleted event for the category item
        /// Then the service should remove the item from the category
        /// </summary>
        /// <returns>A task to run test.</returns>
        [TestMethod]
        public async Task ProcessDeleteItemEventAsyncDeletesTextItem()
        {
            // arrange
            var fakeCategoriesRepository = new FakeCategoriesRepository();

            var category = new CategoryDocument
            {
                Id = "fakecategoryid",
                Name = "fakename",
                UserId = "fakeuserid",
            };

            category.Items.Add(new CategoryItem { Id = "fakeitemid", Type = ItemType.Text });

            fakeCategoriesRepository.CategoryDocuments.Add(category);

            var service = new CategoriesService(
                fakeCategoriesRepository,
                new Mock<IImageSearchService>().Object,
                new Mock<ISynonymService>().Object,
                new Mock<IEventGridPublisherService>().Object);

            var eventToProcess = new EventGridEvent
            {
                Subject = "fakeuserid/fakeitemid",
                EventType = TextEvents.TextDeleted,
                Data = new TextDeletedEventData()
            };

            // act
            await service.ProcessDeleteItemEventAsync(eventToProcess, "fakeuserid").ConfigureAwait(false);

            // assert
            Assert.IsTrue(fakeCategoriesRepository.CategoryDocuments.Single().Items.Count == 0);
        }

        /// <summary>
        /// Given you have an instance of the category service
        /// And the category service has a category with a category item
        /// When you raise the AudioDeleted event for the category item
        /// Then the service should remove the item from the category
        /// </summary>
        /// <returns>A task to run test.</returns>
        [TestMethod]
        public async Task ProcessDeleteItemEventAsyncDeletesAudioItem()
        {
            // arrange
            var fakeCategoriesRepository = new FakeCategoriesRepository();

            var category = new CategoryDocument
            {
                Id = "fakecategoryid",
                Name = "fakename",
                UserId = "fakeuserid",
            };

            category.Items.Add(new CategoryItem { Id = "fakeitemid", Type = ItemType.Audio });

            fakeCategoriesRepository.CategoryDocuments.Add(category);

            var service = new CategoriesService(
                fakeCategoriesRepository,
                new Mock<IImageSearchService>().Object,
                new Mock<ISynonymService>().Object,
                new Mock<IEventGridPublisherService>().Object);

            var eventToProcess = new EventGridEvent
            {
                Subject = "fakeuserid/fakeitemid",
                EventType = AudioEvents.AudioDeleted,
                Data = new AudioDeletedEventData()
            };

            // act
            await service.ProcessDeleteItemEventAsync(eventToProcess, "fakeuserid").ConfigureAwait(false);

            // assert
            Assert.IsTrue(fakeCategoriesRepository.CategoryDocuments.Single().Items.Count == 0);
        }

        /// <summary>
        /// Given you have an instance of the category service
        /// And the category service has a category with a category item
        /// When you raise the AudioDeleted event for the category item
        /// Then the service should publish the CategoryItemsUpdated event.
        /// </summary>
        /// <returns>A task to run test.</returns>
        [TestMethod]
        public async Task ProcessDeleteItemEventAsyncPublishesCategoryItemsUpdatedEventToEventGrid()
        {
            // arrange
            var fakeCategoriesRepository = new FakeCategoriesRepository();

            var category = new CategoryDocument
            {
                Id = "fakecategoryid",
                Name = "fakename",
                UserId = "fakeuserid",
            };

            category.Items.Add(new CategoryItem { Id = "fakeitemid", Type = ItemType.Audio });

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
                EventType = AudioEvents.AudioDeleted,
                Data = new AudioDeletedEventData()
            };

            // act
            await service.ProcessDeleteItemEventAsync(eventToProcess, "fakeuserid").ConfigureAwait(false);

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
