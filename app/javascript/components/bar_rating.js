import $ from 'jquery';
import 'jquery-bar-rating';

const barRating = () => {
  $(function () {
    $('#bar-rating-stars').barrating({
      theme: 'fontawesome-stars',
    });
  });
}

export { barRating };
