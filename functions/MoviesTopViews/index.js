module.exports = async function (context, documents) {
    console.log("Generating MoviesDB top views...");

    // if (!!documents && documents.length > 0) {
    //     context.log('Document Id: ', documents[0].id);
    // }

    const movieCategories = context.bindings.inputMovieCategories
    const movieCategoriesPopularity = context.bindings.inputMovieCategoriesPopularity

    // Find top movie category
    const topMovieCategoryPopularity = movieCategoriesPopularity.reduce(function(x, y){
        return x.Popularity > y.Popularity ? x : y;
    })

    // Find matching movie category object based on category id
    const topMovieCategory = movieCategories.filter(x => x.CategoryId == topMovieCategoryPopularity.CategoryId)

    // Output documents to Cosmos DB
    context.bindings.outputDocuments = [{
        "id": "top-10-movies",
        "topMovies": context.bindings.inputTop10Movies
    },{
        "id": "top-movie-category",
        "topCategoryId": topMovieCategory[0].CategoryId,
        "topCategoryName": topMovieCategory[0].CategoryName,
        "topCategoryPopularity": topMovieCategoryPopularity.Popularity
    }];
}
