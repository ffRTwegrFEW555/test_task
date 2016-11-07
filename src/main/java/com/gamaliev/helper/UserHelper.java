package com.gamaliev.helper;

import com.gamaliev.model.User;
import com.gamaliev.service.UserService;
import org.springframework.ui.Model;

import java.util.List;

public class UserHelper {
    public static StringBuilder getQueryFindAllFields(String prefixText, String textFilter) {
        return new StringBuilder()
                .append(prefixText)
                .append("where cast(id as string)         like '%").append(textFilter).append("%'")
                .append("or cast(name as string)          like '%").append(textFilter).append("%'")
                .append("or cast(age as string)           like '%").append(textFilter).append("%'")
                .append("or cast(isAdmin as string)       like '%").append(textFilter).append("%'")
                .append("or cast(createdDate as string)   like '%").append(textFilter).append("%'");
    }

    public static void getUserList(UserService userService, Integer itemsPerPage, Integer numberOfPage, String textFilter, Model model) {

        //
        List<User> userList = null;

        if (itemsPerPage == null || itemsPerPage <= 0) {
            itemsPerPage = 10;
        }
        if (numberOfPage == null || numberOfPage <= 0) {
            numberOfPage = 1;
        }

        //
        int totalCount = userService.getCountByFilter(textFilter);

        if (totalCount == 0) {
            model   .addAttribute("userList", userList)
                    .addAttribute("totalCountRows", 0)
                    .addAttribute("numberOfPage", 1)
                    .addAttribute("paginationStart", 1)
                    .addAttribute("paginationEnd", 1)
                    .addAttribute("pageToView", 1);
        } else {
            int totalPages = totalCount % itemsPerPage == 0
                    ? totalCount / itemsPerPage
                    : (totalCount / itemsPerPage) + 1;

            if (numberOfPage > totalPages) {
                numberOfPage = totalPages;
            }

            int startPosition = (numberOfPage - 1) * itemsPerPage;
            int endPosition = startPosition + itemsPerPage;
            if (endPosition > totalCount) {
                endPosition = totalCount;
            }

            if (totalCount > startPosition) {
                userList = userService.getSelected(startPosition, endPosition, textFilter);
            } else {
                numberOfPage = totalPages;
                startPosition = ((endPosition / itemsPerPage) * itemsPerPage);
                userList = userService.getSelected(startPosition, endPosition, textFilter);
            }

            int paginationEnd = numberOfPage + 3 > totalPages
                    ? totalPages
                    : numberOfPage > 2
                        ? numberOfPage + 2
                        : numberOfPage == 1
                            ? numberOfPage + 4
                            : numberOfPage + 3;
            int paginationStart = paginationEnd - 4 >= 1 ? paginationEnd - 4 : 1;
            int pageToView = totalPages > 5 ? 5 : totalPages;

            model   .addAttribute("userList", userList)
                    .addAttribute("totalCountRows", totalCount)
                    .addAttribute("numberOfPage", numberOfPage)
                    .addAttribute("paginationStart", paginationStart)
                    .addAttribute("paginationEnd", paginationEnd)
                    .addAttribute("pageToView", pageToView)
                    .addAttribute("startPosition", startPosition)
                    .addAttribute("endPosition", endPosition);
        }
    }
}
