--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "tufte-css/tufte.css" $ do
        route $ customRoute $ drop 10 . toFilePath
        compile compressCssCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler
    
    match "tufte-css/et-book/*/*" $ do
        route $ customRoute $ drop 10 . toFilePath
        compile copyFileCompiler

    create ["styles.css"] $ do
        route idRoute
        compile $ do
            t <- load "tufte-css/tufte.css"
            c <- loadAll "css/*.css"
            makeItem $ unlines $ map itemBody $ t:c

    match (fromList ["about.md"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls
    
    match "notes/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls

    create ["notes.html"] $ do
        route idRoute
        compile $ do
            notes <- loadAll "notes/*"
            let notesCtx =
                    listField "notes" defaultContext (return notes)
                    <> defaultContext                    
            makeItem ""
                >>= loadAndApplyTemplate "templates/notes.html" notesCtx
                >>= loadAndApplyTemplate "templates/default.html" notesCtx
                >>= relativizeUrls


    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler


--------------------------------------------------------------------------------

postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext
