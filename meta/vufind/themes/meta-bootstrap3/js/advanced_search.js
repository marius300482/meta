/*global addSearchString, searchFields, searchFieldLabel, searchLabel, searchMatch */

var nextGroup = 0;

function addSearch(group, term, field)
{
  // Does anyone use this???
  if (term  == undefined) {term  = '';}
  if (field == undefined) {field = '';}

  // Build the new search
  var inputIndex = $('#group'+group+' input').length;
  var inputID = group+'_'+$('#group'+group+' input').length;
  var newSearch = '<div class="search" id="search'+inputID+'"><div class=""><div class="col-sm-7 col-xs-12"><input id="search_lookfor'+inputID+'" class="form-control" type="text" name="lookfor'+group+'[]" value="'+term+'"/></div>'
    + '<div class="col-sm-4 col-xs-11"><select id="search_type'+inputID+'" name="type'+group+'[]" class="form-control">';
  for (var key in searchFields) {
    newSearch += '<option value="' + key + '"';
    if (key == field) {
      newSearch += ' selected="selected"';
    }
    newSearch += ">" + searchFields[key] + "</option>";
  }
  newSearch += '</select></div><div class="col-xs-1"><a class="help-block delete" href="#" onClick="deleteSearch('+group+','+inputIndex+')" class="delete">X</a></div></div>';

  // Insert it
  $("#group" + group + "Holder").before(newSearch);
  // Show x
  $('#group'+group+' .search .delete').removeClass('hidden');
}

function deleteSearch(group, eq)
{
  var searches = $('#group'+group+' .search');
  for(var i=eq;i<searches.length-1;i++) {
    $(searches[i]).find('input').val($(searches[i+1]).find('input').val());
    var select0 = $(searches[i]).find('select')[0];
    var select1 = $(searches[i+1]).find('select')[0];
    select0.selectedIndex = select1.selectedIndex;
  }
  if($('#group'+group+' .search').length > 1) {
    $('#group'+group+' .search:last').remove();
  }
  // Hide x
  if($('#group'+group+' .search').length == 1) {
    $('#group'+group+' .search .delete').addClass('hidden');
  }
}

function addGroup(firstTerm, firstField, join)
{
  if (firstTerm  == undefined) {firstTerm  = '';}
  if (firstField == undefined) {firstField = '';}
  if (join       == undefined) {join       = '';}

  var newGroup = '<div id="group'+nextGroup+'" class="group clearfix">' +
      '<div class="col-sm-6">' +
          // '<label>'+searchLabel+':</label>' + // PHE not required
          '<i id="group'+nextGroup+'Holder" class="fa fa-plus-circle"></i> <a href="#" onClick="addSearch('+nextGroup+')">'+addSearchString+'</a>' +
      '</div>'
    + '<div class="col-sm-6">'
    + '<label for="search_bool'+nextGroup+'">'+searchMatch+':&nbsp;</label>'
    + '<a href="#" onClick="deleteGroup('+nextGroup+')" class="close hidden" title="'+deleteSearchGroupString+'">X</a>'
    + '<select id="search_bool'+nextGroup+'" name="bool'+nextGroup+'[]" class="form-control">'
    + '<option value="AND"';
  if(join == 'AND') {
    newGroup += ' selected';
  }
  newGroup += '>' +searchJoins['AND'] + '</option>'
    + '<option value="OR"';
  if(join == 'OR') {
    newGroup += ' selected';
  }
  newGroup += '>' +searchJoins['OR'] + '</option>'
    + '<option value="NOT"';
  if(join == 'NOT') {
    newGroup += ' selected';
  }
  newGroup += '>' +searchJoins['NOT'] + '</option>'
    + '</select></div></div>';

  $('#groupPlaceHolder').before(newGroup);
  addSearch(nextGroup, firstTerm, firstField);
  // Show join menu
  if($('.group').length > 1) {
    $('#groupJoin').removeClass('hidden');
    // Show x
    $('.group .close').removeClass('hidden');
  }
  return nextGroup++;
}

function deleteGroup(group)
{
  // Find the group and remove it
  $("#group" + group).remove();
  // If the last group was removed, add an empty group
  if($('.group').length == 0) {
    addGroup();
  } else if($('.group').length == 1) { // Hide join menu
    $('#groupJoin').addClass('hidden');
    // Hide x
    $('.group .close').addClass('hidden');
  }
}

// Fired by onclick event
function deleteGroupJS(group)
{
  var groupNum = group.id.replace("delete_link_", "");
  deleteGroup(groupNum);
  return false;
}

// Fired by onclick event
function addSearchJS(group)
{
  var groupNum = group.id.replace("add_search_link_", "");
  addSearch(groupNum);
  return false;
}

// Show all institution facets
$(function(){
    moreFacets('institution');
});

/**
 * PHE: Toggling of the simple and advanced search
 */
$(document).ready(function() {
    var simpleSearchTab = $("#advanceSearchTab"),
        simpleSearchBody = $("#simple-search-body"),
        advancedSearchTab = $("#simpleSearchTab"),
        advancedSearchBody = $("#advSearchForm");

    simpleSearchTab.click(function () {
        simpleSearchTab.addClass("active");
        advancedSearchTab.removeClass("active");
        simpleSearchBody.addClass("hidden");
        advancedSearchBody.removeClass("hidden");
    });

    advancedSearchTab.click(function () {
        simpleSearchTab.removeClass("active");
        advancedSearchTab.addClass("active");
        simpleSearchBody.removeClass("hidden");
        advancedSearchBody.addClass("hidden");
    });
});