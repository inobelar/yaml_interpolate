#ifndef FAILURE_MESAGE_HPP
#define FAILURE_MESAGE_HPP

#include <cstdio>  // for std::fprintf()
#include <cstdlib> // for std::exit()

template <typename ... Args>
inline void failure_message(int exit_code, const char* fmt, Args&& ... args)
{
    std::fprintf(stderr, fmt, args ...);
    std::exit(exit_code);
}

#endif // FAILURE_MESAGE_HPP
