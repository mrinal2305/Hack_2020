const express = require('express');
const router = express.Router();

const NaturalLanguageUnderstandingV1 = require('ibm-watson/natural-language-understanding/v1');
const { IamAuthenticator } = require('ibm-watson/auth');

const naturalLanguageUnderstanding = new NaturalLanguageUnderstandingV1({
    version: '2019-07-12',
    authenticator: new IamAuthenticator({
      apikey: '1tcWE3chd2Gf_XGZ9kS20jvCP58z4kVSDZbzdctcj10H',
    }),
    url: 'https://api.eu-gb.natural-language-understanding.watson.cloud.ibm.com/instances/d757a019-2724-460f-b8a0-0605a1ad7dcf',
  });

router.get('/',(req,res,next)=>{
  res.send({
    message : "Add text field"
  })
})

router.get('/:text',(req,res,next)=>{
  //Analyzing text
  const analyzeParams = {
    text:req.params.text,
    'features': {
    'concepts': {
      'limit': 5
    }
  }
};
  //NLP concept output
  naturalLanguageUnderstanding.analyze(analyzeParams)
  .then(analysisResults => {
    var output = JSON.stringify(analysisResults, null, 2);
    data  = JSON.parse(output);
    var result = {
      text_characters : data.result.usage.text_characters,
      concept         : data.result.concepts
    }
   
    res.send(result);
  })
  .catch(err => {

    console.log('error:', err);
  });

})

  module.exports = router;