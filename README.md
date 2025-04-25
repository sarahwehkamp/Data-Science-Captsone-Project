# Data-Science-Capstone-Project: Next Word Prediction App 🗣️✨

**About Natural Language Processing (NLP) 🧠:**

* **N-grams**: 🔗 A continuous sequence of 'n' items (like words!) from text or speech. Think of it as word combos!
    * **Unigrams**: One single word. ☝️
    * **Bigrams**: Two-word teams. ✌️
    * **Trigrams**: Three-word trios. 👌
* **Tokenization**: ✂️ Breaking down text into meaningful units called **tokens** (usually words!).
* **Corpus**: 📚 A clean collection of text used for training. We make it sparkle ✨ by removing extra stuff like spaces, numbers, weird symbols, and bad words! 🧼
* **Language Models**: 🤖 Assigning probabilities to word sequences based on what came before. They learn to guess what might come next! 🤔
* **Katz Back-Off Model**: 🪜 A smart way to predict the next word. It first checks if it has seen the **four** previous words together a lot (Quadgram). If not, it \\\"backs off\\\" to checking the **three** previous words (Trigram), then **two** (Bigram).

**The Magic Behind Prediction ✨🔮:**

* **Chain Rule**: 🔗 Basically, the chance of a whole sentence is the product of the chances of each word given the words before it.  `P(Word1, Word2, Word3...) = P(Word1) * P(Word2|Word1) * P(Word3|Word1, Word2) * ...`
* **Why not *just* the Chain Rule?** 😩 Too many possible sentences! We wouldn't have enough data to learn all those combinations perfectly. 🤯
* **Markov Assumption**: ➡️ We make a simplifying assumption: the next word mostly depends on the *few* words right before it, not the *entire* history. (Think Bigrams and Trigrams!)
* **Markov Random Process**: 🎲 A sequence where the future only depends on the present. (Like our n-gram logic!)
* **Markov Model**: ⚙️ A system that follows the Markov Assumption.
* **Markov Chain**: ⛓️ The sequence of predicted words from our model.
* **Katz Back-Off Model (again!)**: 🦸 Our hero for prediction! It uses the Quadgram, Trigram, and Bigram probabilities in a smart \\\"back-off\\\" strategy.

**Building the Prediction Powerhouse 💪:**

* **Generating N-gram Datasets**: 📊 We created tables of word frequencies for Unigrams, Bigrams, Trigrams, and Quadgrams.
* **Data Source**: 💾 The data came from the **HC Corpora** (Blogs, News, and Twitter).
* **Data Cleaning & Preparation**: 🧹 We took the raw text, made it lowercase, and removed punctuation, links, extra spaces, numbers, and profanity.
* **Tokenization**: 🧩 We broke the cleaned text into individual words (tokens) and then created our n-grams.
* **N-gram Frequency Matrices**: 🔢 The Unigram, Bigram, Trigram, and Quadgram data are stored in matrices showing how often each word or word combination appears. These are the \\\"brains\\\" of our prediction algorithm! 🧠
* **Saving for Speed**: 💾 To make the app run faster, we saved each n-gram dataset separately. ⚡

