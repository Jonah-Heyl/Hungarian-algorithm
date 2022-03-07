{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "VSE Jonah Heyl hungarain algorithim"
  "This algorithim is based off other implementations found below"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "using Statistics"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 482,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "3×3 Matrix{Int64}:\n",
       " 7  5  6\n",
       " 6  9  1\n",
       " 4  1  2"
      ]
     },
     "execution_count": 482,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "A= rand(1:10,(3, 3))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 472,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "w (generic function with 1 method)"
      ]
     },
     "execution_count": 472,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "function w(v)\n",
    "    w=[]\n",
    "    for i in w\n",
    "        if i==true\n",
    "            push!(w,i)\n",
    "        end\n",
    "    end\n",
    "    return w\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 473,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "min_zero_row (generic function with 1 method)"
      ]
     },
     "execution_count": 473,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "function min_zero_row(zero_mat, mark_zero)\n",
    "    min_row = [99999, -1]\n",
    "     \n",
    "    v=[]\n",
    "    for i in range(1,size(zero_mat)[1])\n",
    "        count=0\n",
    "        for j in zero_mat[i,:]\n",
    "            if j\n",
    "                count=count+1\n",
    "            end\n",
    "        end\n",
    "        push!(v,count)\n",
    "    end\n",
    "    min_row=findmin(v)[2]\n",
    "    zero_index = w(zero_mat[min_row,:])\n",
    "    for i in range(1,size(zero_index)[1])\n",
    "        push!(mark_zero,((min_row[1], zero_index[i]))) # check this\n",
    "    end\n",
    "    for i in range(1,size(zero_mat)[1])\n",
    "        zero_mat[min_row[1], i] = false\n",
    "    end\n",
    "    for j in range(1,size(zero_index)[1])\n",
    "        zero_mat[:, zero_index] = false\n",
    "    end\n",
    "end\n",
    "    "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 76,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "cov (generic function with 1 method)"
      ]
     },
     "execution_count": 76,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "function cov(S,A) #converts the set into a vector\n",
    "    v=[]\n",
    "    for i in range(findmin(A)[2],findmax(A)[2]) #this assumes A is a matrix of inetegers\n",
    "        if (in(S).i)\n",
    "            push!(v,i)\n",
    "        end\n",
    "    end\n",
    "    return v\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 77,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "nope (generic function with 1 method)"
      ]
     },
     "execution_count": 77,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "function nope(cover_rows,row)\n",
    "    for x  in cover_rows\n",
    "        if (x == row)\n",
    "            return false\n",
    "        end\n",
    "    end\n",
    "    return true\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 419,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "mark_matrix (generic function with 1 method)"
      ]
     },
     "execution_count": 419,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "function mark_matrix(mat)\n",
    "    cur_mat = mat\n",
    "    v=[]\n",
    "    for x in cur_mat\n",
    "        if x==0\n",
    "            push!(v,true)\n",
    "        end\n",
    "        if x!=0\n",
    "            push!(v,false)\n",
    "        end\n",
    "    end\n",
    "   \n",
    "    zero_bool_mat= reshape(v,size(cur_mat))\n",
    "    zero_bool_mat_copy = copy(zero_bool_mat)\n",
    "     \n",
    "    marked_zero = []\n",
    "    while (true in zero_bool_mat_copy)\n",
    "        min_zero_row(zero_bool_mat_copy, marked_zero)\n",
    "    end\n",
    "    marked_zero_row = []\n",
    "    marked_zero_col = []\n",
    "\n",
    "    for i in range(1,size(marked_zero)[1])\n",
    "        \n",
    "        push!(marked_zero_row,(marked_zero[i,1]))\n",
    "        push!(marked_zero_col,(marked_zero[i,1]))\n",
    "    end\n",
    "\n",
    "    non_marked_row =[setdiff(Set(range(1,size(cur_mat)[1])),Set(marked_zero_row))]\n",
    "    non_marked_row=cov(non_marked_row,A)\n",
    "     \n",
    "    marked_cols=[]\n",
    "    \n",
    "    check_switch = true\n",
    "\n",
    "    \n",
    "    while check_switch\n",
    "        check_switch = false\n",
    "        for i in range(1,size(non_marked_row)[1])  \n",
    "            \n",
    "            row_array = zero_bool_mat[non_marked_row[i],:]\n",
    "            for j in range(1,size(row_array))\n",
    "                if row_array[j] == true && nope(marked_cols,j)\n",
    "                    push!(marked_cols,j)\n",
    "                    check_switch = true\n",
    "                end\n",
    "            end\n",
    "        end\n",
    "    end\n",
    "           \n",
    "        for row_num in marked_zero\n",
    "            for col_num in marked_zero\n",
    "                if row_num not in non_marked_row && col_num in marked_cols\n",
    "                    push!(non_marked_row,row_num)\n",
    "                    check_switch = true\n",
    "                end\n",
    "            end\n",
    "        end\n",
    "\n",
    "    marked_rows = [setdiff(Set(range(1,size(mat)[1])),Set(non_marked_row))]\n",
    "    marked_rows=cov(marked_rows,A)\n",
    "    return(marked_zero, marked_rows, marked_cols)\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": 475,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "adjust_matrix (generic function with 1 method)"
      ]
     },
     "execution_count": 475,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "function adjust_matrix(mat, cover_rows, cover_cols)\n",
    "    cur_mat = mat\n",
    "    non_zero_element = []\n",
    "    for row in range(1,size(cur_mat)[1])\n",
    "        if nope(cover_rows,row)\n",
    "            for i in range(1,size(cur_mat[row]))\n",
    "                if nope(cover_cols,i)\n",
    "                    push!(non_zero_element,cur_mat[row][i])\n",
    "                end\n",
    "            end\n",
    "        end\n",
    "    end\n",
    "    min_num = findmin(non_zero_element)[1]\n",
    "\n",
    "     \n",
    "    for row in range(1,size(cur_mat)[1])\n",
    "        if nope(cover_rows,row)\n",
    "            for i in range(1,size(cur_mat[row])[1])\n",
    "                if nope(cover_cols,i)\n",
    "                    cur_mat[row, i] = cur_mat[row][i] - min_num\n",
    "                end\n",
    "            end\n",
    "        end\n",
    "    end\n",
    "  \n",
    "\n",
    "    for row in range(1,size(cover_rows)[1])\n",
    "        for col in range(1,size(cover_cols)[1])\n",
    "            cur_mat[cover_rows[row], cover_cols[col]] = cur_mat[cover_rows[row], cover_cols[col]] + min_num       \n",
    "        end\n",
    "    end\n",
    "    return cur_mat\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 476,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "hungarian_algorithm (generic function with 1 method)"
      ]
     },
     "execution_count": 476,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "function hungarian_algorithm(mat)\n",
    "    cur_mat = mat\n",
    "\n",
    "    for row_num in range(1,size(mat)[1])\n",
    "        cur_mat[row_num] = cur_mat[row_num] .- findmin(cur_mat[row_num])[1]\n",
    "    end\n",
    "    \n",
    "    for col_num in range(1,size(mat)[2])\n",
    "        cur_mat[:,col_num] = cur_mat[:,col_num] .- findmin(cur_mat[:,col_num])[1]\n",
    "    end\n",
    "    zero_count = 0\n",
    "\n",
    "    while zero_count < size(mat)[1]\n",
    "        \n",
    "        ans_pos, marked_rows, marked_cols = mark_matrix(cur_mat)\n",
    "        zero_count = size(marked_rows)[1] + size(marked_cols)[1]\n",
    "        \n",
    "        if zero_count < size(mat)[1]\n",
    "            \n",
    "            cur_mat = adjust_matrix(cur_mat, marked_rows, marked_cols)\n",
    "            \n",
    "        end\n",
    "    end\n",
    "\n",
    "    return ans_pos\n",
    "end\n",
    "            "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 478,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "ans_calculation (generic function with 1 method)"
      ]
     },
     "execution_count": 478,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "function ans_calculation(mat, pos)\n",
    "    total = 0\n",
    "    ans_mat = zeros(size(mat))\n",
    "    for i in range(len(pos))\n",
    "        total = total + (mat[pos[i,0], pos[i,1]])\n",
    "        ans_mat[pos[i,0], pos[i,1\"]] = mat[pos[i][0], pos[i,1]]\n",
    "    end\n",
    "    return total, ans_mat\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 483,
   "metadata": {},
   "outputs": [
    {
     "ename": "LoadError",
     "evalue": "InterruptException:",
     "output_type": "error",
     "traceback": [
      "InterruptException:",
      "",
      
     ]
    }
   ],
   "source": [
    "ans_pos = hungarian_algorithm(copy(A))\n",
    "ans, ans_mat = ans_calculation(A, ans_pos)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Also See:\n",
    "https://launchpad.net/lib-bipartite-match\n",
    "http://software.clapper.org/munkres/\n",
    "https://en.wikipedia.org/wiki/Hungarian_algorithm\n",
    "https://github.com/KevinStern/software-and-algorithms/blob/master/src/main/java/blogspot/software_and_algorithms/stern_library/optimization/HungarianAlgorithm.java\n",
    "https://python.plainenglish.io/hungarian-algorithm-introduction-python-implementation-93e7c0890e15\n",
    "https://github.com/maandree/hungarian-algorithm-n3/blob/master/hungarian.c"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Julia 1.7.1",
   "language": "julia",
   "name": "julia-1.7"
  },
  "language_info": {
   "file_extension": ".jl",
   "mimetype": "application/julia",
   "name": "julia",
   "version": "1.7.1"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
