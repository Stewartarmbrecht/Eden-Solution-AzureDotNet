namespace MyEdenSolution.Categories.Tests.UnitTests
{
    using System.Linq;
    using System.Threading.Tasks;
    using MyEdenSolution.Categories.Services;
    using MyEdenSolution.Categories.Services.Models.Data;
    using MyEdenSolution.Categories.Services.Models.Results;
    using MyEdenSolution.Categories.Services.Repositories;
    using MyEdenSolution.Common;
    using MyEdenSolution.Common.EventSchemas.Categories;
    using MyEdenSolution.Common.Events;
    using Microsoft.Extensions.Localization;
    using Microsoft.VisualStudio.TestTools.UnitTesting;
    using Moq;

    /// <summary>
    /// Contains all unit tests for the Categories service update operation.
    /// </summary>
    [TestClass]
    public class CategoriesServiceUpdateTests
    {
        /// <summary>
        /// Given you have a category service
        /// And the category service has a category defined
        /// When you update the category using the UpdateCategoryAsync operation
        /// Then the service should return a response with a Success status code.
        /// </summary>
        /// <returns>A task to run test.</returns>
        [TestMethod]
        public async Task UpdateCategoryReturnsSuccess()
        {
            // arrange
            var fakeCategoriesRepository = new FakeCategoriesRepository();
            fakeCategoriesRepository.CategoryDocuments.Add(new CategoryDocument { Id = "fakeid", UserId = "fakeuserid" });
            var service = new CategoriesService(
                fakeCategoriesRepository,
                new Mock<IImageSearchService>().Object,
                new Mock<ISynonymService>().Object,
                new Mock<IEventGridPublisherService>().Object);

            // act
            var result = await service.UpdateCategoryAsync("fakeid", "fakeuserid", "newname").ConfigureAwait(false);

            // assert
            Assert.AreEqual(UpdateCategoryResult.Success, result);
        }

        /// <summary>
        /// Given you have a category service
        /// And the category service has a category defined
        /// When you update the category using the UpdateCategoryAsync operation
        /// Then the service should update the name of the category
        /// </summary>
        /// <returns>A task to run test.</returns>
        [TestMethod]
        public async Task UpdateCategoryUpdatesDocumentInRepository()
        {
            // arrange
            var fakeCategoriesRepository = new FakeCategoriesRepository();
            fakeCategoriesRepository.CategoryDocuments.Add(new CategoryDocument { Id = "fakeid", Name = "oldname", UserId = "fakeuserid" });
            var service = new CategoriesService(
                fakeCategoriesRepository,
                new Mock<IImageSearchService>().Object,
                new Mock<ISynonymService>().Object,
                new Mock<IEventGridPublisherService>().Object);

            // act
            await service.UpdateCategoryAsync("fakeid", "fakeuserid", "newname").ConfigureAwait(false);

            // assert
            Assert.AreEqual("newname", fakeCategoriesRepository.CategoryDocuments.Single().Name);
        }

        /// <summary>
        /// Given you have a category service
        /// And the category service has a category defined
        /// When you update the category using the UpdateCategoryAsync operation
        /// Then the service should publish the CategoryNameUpdatedEvent
        /// </summary>
        /// <returns>A task to run test.</returns>
        [TestMethod]
        public async Task UpdateCategoryPublishesCategoryNameUpdatedEventToEventGrid()
        {
            // arrange
            var fakeCategoriesRepository = new FakeCategoriesRepository();
            fakeCategoriesRepository.CategoryDocuments.Add(new CategoryDocument { Id = "fakeid", UserId = "fakeuserid" });
            var mockEventGridPublisherService = new Mock<IEventGridPublisherService>();
            var service = new CategoriesService(
                fakeCategoriesRepository,
                new Mock<IImageSearchService>().Object,
                new Mock<ISynonymService>().Object,
                mockEventGridPublisherService.Object);

            // act
            await service.UpdateCategoryAsync("fakeid", "fakeuserid", "newname").ConfigureAwait(false);

            // assert
            mockEventGridPublisherService.Verify(
                m => m.PostEventGridEventAsync(
                    CategoryEvents.CategoryNameUpdated,
                    "fakeuserid/fakeid",
                    It.Is<CategoryNameUpdatedEventData>(d => d.Name == "newname")),
                Times.Once);
        }

        /// <summary>
        /// Given you have a category service
        /// And the category service has a category defined
        /// When you update the category using the UpdateCategoryAsync operation with an invalid category id
        /// Then the service should return a response with a Not Found status code.
        /// </summary>
        /// <returns>A task to run test.</returns>
        [TestMethod]
        public async Task UpdateCategoryInvalidCategoryIdReturnsNotFound()
        {
            // arrange
            var service = new CategoriesService(
                new Mock<ICategoriesRepository>().Object,
                new Mock<IImageSearchService>().Object,
                new Mock<ISynonymService>().Object,
                new Mock<IEventGridPublisherService>().Object);

            // act
            var result = await service.UpdateCategoryAsync("fakeid", "fakeuserid", "newname").ConfigureAwait(false);

            // assert
            Assert.AreEqual(UpdateCategoryResult.NotFound, result);
        }

        /// <summary>
        /// Given you have a category service
        /// And the category service has a category defined
        /// When you update the category using the UpdateCategoryAsync operation with an invalid user id
        /// Then the service should return a response with a Not Found status code.
        /// </summary>
        /// <returns>A task to run test.</returns>
        [TestMethod]
        public async Task UpdateCategoryIncorrectUserIdReturnsNotFound()
        {
            // arrange
            var fakeCategoriesRepository = new FakeCategoriesRepository();
            fakeCategoriesRepository.CategoryDocuments.Add(new CategoryDocument { Id = "fakeid", UserId = "fakeuserid2" });
            var service = new CategoriesService(
                fakeCategoriesRepository,
                new Mock<IImageSearchService>().Object,
                new Mock<ISynonymService>().Object,
                new Mock<IEventGridPublisherService>().Object);

            // act
            var result = await service.UpdateCategoryAsync("fakeid", "fakeuserid", "newname").ConfigureAwait(false);

            // assert
            Assert.AreEqual(UpdateCategoryResult.NotFound, result);
        }
    }
}
